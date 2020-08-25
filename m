Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1950F251747
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgHYLR4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbgHYLRD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:17:03 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F0020706;
        Tue, 25 Aug 2020 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598354222;
        bh=vSpmQn4xmS6/grD1JzGMM6++5te9IH8lEvR0a9aD1J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPYRlrbcBGrmnRwKyuq297LgjOVaHKi1ilmlnUZE8780EA5Y/P0cwSCSkkWQA2900
         J4MGGiPj++oD1FRClua7fA9VhIfXQ5fsGr8PutMhjVbDlwOXvcObjoUZyiTJdtKR24
         L0r873LqzouhzoApMEOO2r3YZKGKz36BUATTNJ9c=
Date:   Tue, 25 Aug 2020 16:46:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dmaengine: ptdma: Initial driver for the AMD
 PTDMA controller
Message-ID: <20200825111659.GM2639@vkoul-mobl>
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
 <1592356288-42064-2-git-send-email-Sanju.Mehta@amd.com>
 <20200703071841.GJ273932@vkoul-mobl>
 <19b20b55-0748-fb3c-755d-87ee6bdccf48@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b20b55-0748-fb3c-755d-87ee6bdccf48@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-08-20, 13:11, Sanjay R Mehta wrote:
> Apologies for my delayed response.
> 
> On 7/3/2020 12:48 PM, Vinod Koul wrote:
> > [CAUTION: External Email]
> > 
> > On 16-06-20, 20:11, Sanjay R Mehta wrote:
> > 
> >> +static int pt_core_execute_cmd(struct ptdma_desc *desc,
> >> +                            struct pt_cmd_queue *cmd_q)
> >> +{
> >> +     __le32 *mp;
> >> +     u32 *dp;
> >> +     u32 tail;
> >> +     int     i;
> > 
> > no tabs, spaces pls
> Sure, will fix in the next version of patch.

Also, please make sure you run checkpatch.pl with --strict option, that
will help out reducing the churn here

Thanks
-- 
~Vinod
