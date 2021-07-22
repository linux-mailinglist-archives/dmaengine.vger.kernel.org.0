Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB13D2C2F
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jul 2021 20:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhGVSQU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jul 2021 14:16:20 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42476
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhGVSQU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Jul 2021 14:16:20 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EA4203F224;
        Thu, 22 Jul 2021 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626980214;
        bh=sB8qp9ivM8n28sdXFVpMHUr9NTbiCrxpWCndjr7l/Ek=;
        h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type;
        b=KEglPHnIfPyfDBCZjvmNwouyrbJsRQxjjHiDf+Tfb8c+hbynbgcvSmeIncTGaUgGK
         t8S0lcMmHar7+C5y2/7H2wMPZwBNxqenj8Sph3PcTPsZmDSc/ZVWd7bTu2jP8OII8p
         CcagJR1ni3WbQDGryKgx5l4Vi4qE6pAf/SiqtWynZtdJDUDNfEej14v6vMtwDxq/vU
         blrKCqnikfuZxWHQ4vL5JCXXZ2P7MC+fj7WxM/kBTAoh0Ozdl3qmT8eyI99teIBtqJ
         HjbCFHcRGyDUAszLvoWOM5h71XBop+eOPnt03sJomt8u4L4K6/gRWa0/3KEpobesgj
         W8nS6M8t6SMfg==
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: dmaengine: idxd: fix submission race window
Message-ID: <92a5510c-f426-1001-5311-6c615df2e7de@canonical.com>
Date:   Thu, 22 Jul 2021 19:56:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Static analysis with Coverity on Linux-next has found an issue with the
following commit:

commit 6b4b87f2c31ac1af4f244990a7cbfb50d3f3e33f
Author: Dave Jiang <dave.jiang@intel.com>
Date:   Wed Jul 14 11:50:06 2021 -0700

    dmaengine: idxd: fix submission race window

The analysis is as follows:

180static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
181                                     int *processed, u64 data)
182{
183        struct idxd_desc *desc, *t;
184        struct llist_node *head;
185        int queued = 0;
186        unsigned long flags;
187
188        *processed = 0;
189        head = llist_del_all(&irq_entry->pending_llist);
190        if (!head)
191                goto out;
192
193        llist_for_each_entry_safe(desc, t, head, llnode) {

   assignment: Assigning: status = (*desc).completion->status & 0x7f.

194                u8 status = desc->completion->status &
DSA_COMP_STATUS_MASK;
195

   cond_between: Condition status, taking true branch. Now the value of
status is between 1 and 127.
   cond_cannot_single: Condition status, taking true branch. Now the
value of status cannot be equal to 0.

196                if (status) {

   between: At condition status == IDXD_COMP_DESC_ABORT, the value of
status must be between 1 and 127.
   cond_cannot_set: Condition status == IDXD_COMP_DESC_ABORT, taking
false branch. Now the value of status cannot be equal to any of {0, 255}.

   cannot_single: At condition status == IDXD_COMP_DESC_ABORT, the value
of status cannot be equal to 0.
   dead_error_condition: The condition !!(status ==
IDXD_COMP_DESC_ABORT) cannot be true.

197                        if (unlikely(status == IDXD_COMP_DESC_ABORT)) {
   Logically dead code (DEADCODE)
   dead_error_begin: Execution cannot reach this statement:

   complete_desc(desc, IDXD_CO....

198                                complete_desc(desc, IDXD_COMPLETE_ABORT);
199                                (*processed)++;
200                                continue;
201                        }
202
203                        complete_desc(desc, IDXD_COMPLETE_NORMAL);
204                        (*processed)++;

The check (status == IDXD_COMP_DESC_ABORT) is always false since status
was previously masked with 0x7f and IDXD_COMP_DESC_ABORT is 0xff

Colin.
