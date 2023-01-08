Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC96466178D
	for <lists+dmaengine@lfdr.de>; Sun,  8 Jan 2023 18:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAHRgO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Jan 2023 12:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjAHRgK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 8 Jan 2023 12:36:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77463BC
        for <dmaengine@vger.kernel.org>; Sun,  8 Jan 2023 09:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uKx/6wNbKp0TIcFEhLz5OI0WO0orOz47Y6mrSwwiEyQ=; b=FUO2WOCC5NyD8C6UPyz9qvRX1H
        XgVBb53AjH0CEyKrTTMcnLzi38cTJH25rYeBhkaRv2X0t2bkfq1cLJiNTm5NIEpNb4My3CdXIZGv1
        OGxzNG3KLF9iMEZAW2GcerJXSXUqa5U19oiiwK+/yJ5wIHPO8Hl4MI/zdGSc/JjzFJTcm6EieDF5+
        5eoTHY7aeOwzuf+771xCGw1DhHwPW63o6qjj1HCr2kvrWisXHVfJ7Vo2AA4fkEeIa9zCMhrJ6B6I0
        c56rMi3b892tWAPwwYwzQH3zdI4CtZ9r8MBsdUzFirEA9wE9WK97PA3+d982oH5cdSQXUnrc4ZYuG
        exQE58Fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEZaY-00EepB-Bo; Sun, 08 Jan 2023 17:36:06 +0000
Date:   Sun, 8 Jan 2023 09:36:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Message-ID: <Y7r/BjWEP2q64TGy@infradead.org>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7RpuqbTAM11wVQG@lucifer>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Exporting access_remote_vm just seems like a horrible idea.

If a driver needs to access a different VM from a completion path
in some thread or workqueue (which I assume this does, if not please
explain the use case), it should use kthread_use_mm to associate the
mm struct and then just use all the normal uaccess helpers.
