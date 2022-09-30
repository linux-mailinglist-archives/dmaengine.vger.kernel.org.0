Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3593F5F11B4
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiI3Sj7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiI3Sj4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 14:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3169331213
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664563191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9f9pRxAV2K4hxfZ3xhMSHngwvQPtF7+EWHpgTBwwYM=;
        b=WEYYWlbAvxlvFJoxWK14cimo+tjLhtIgeGbZv00rZOCAZtdMWrz6YmuW7T9Y6AHGzP7Bt4
        Q5j2jPZxe/rmLfMLVCrOJ9RBoHksDOD9PmNKlRK3VkFh2BCiHf0rQyqvRgxFaWfpVtW22G
        Y4V3EgPFYi8MRcJK7XX2aNwq85zsb4Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-dONmQWF3MHW5F-3QnamP7A-1; Fri, 30 Sep 2022 14:39:48 -0400
X-MC-Unique: dONmQWF3MHW5F-3QnamP7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB1BF101A528;
        Fri, 30 Sep 2022 18:39:47 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.11.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 566E52166B26;
        Fri, 30 Sep 2022 18:39:45 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     koba.ko@canonical.com
Cc:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        haijie1@huawei.com, jsnitsel@redhat.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH V2] dmaengine: Fix client_count is countered one more incorrectly.
Date:   Fri, 30 Sep 2022 21:39:17 +0300
Message-Id: <20220930183917.1390019-1-jsavitz@redhat.com>
In-Reply-To: <20220930173652.1251349-1-koba.ko@canonical.com>
References: <20220930173652.1251349-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tested-by: Joel Savitz <jsavitz@redhat.com>
Reviewed-by: Joel Savitz <jsavitz@redhat.com>

