Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3955AF54
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jun 2022 07:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiFZFgR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Jun 2022 01:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZFgQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Jun 2022 01:36:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00913DEA;
        Sat, 25 Jun 2022 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656221775; x=1687757775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kblb61Kx0cy7fIE3JvdSA0q4mukZjRDnLg/zeZBGwCI=;
  b=fKNwhDU2WDkBlD4mMsyXzVq3+C1Ohem8sStnVwLNGcLUHjQ4/wBQBEY4
   jBKYn2Uwwr0k+xPOKTijTeYazLJXulYF2blN5vo/KBIXPsps6bG4lxEWP
   flVwKgjPToNe6eXzZ9KgMg4xtTYrBMpAxKaGBBuQYiCJYFwIBfQGy2q90
   tR9owOJmP6zG2TeTEsLxw1CQh4Lbmv5xylqOqW6qklqkz7T8J+krIduAG
   aLDwUUYPLXNbHDyU79hlWRcSXyiLSl7CbQFoXV/f3OzzdPHq/NoTxLFgB
   HqQxtzf55QDyTB+tOKKXOkNlE8hmMALiTTZquw/YdzO8bOHZRWs4l4v9H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="261665108"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="261665108"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 22:36:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="645892285"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 22:36:14 -0700
Date:   Sat, 25 Jun 2022 22:36:40 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3] dmaengine: idxd: Only call idxd_enable_system_pasid()
 if succeeded in enabling SVA feature
Message-ID: <YrfwaC06wZfUTHjH@fyu1.sc.intel.com>
References: <20220625221333.214589-1-jsnitsel@redhat.com>
 <20220626051648.14249-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626051648.14249-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 25, 2022 at 10:16:48PM -0700, Jerry Snitselaar wrote:
> On a Sapphire Rapids system if boot without intel_iommu=on, the IDXD
> driver will crash during probe in iommu_sva_bind_device().
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
