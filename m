Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D4697AC5
	for <lists+dmaengine@lfdr.de>; Wed, 15 Feb 2023 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjBOLa6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Feb 2023 06:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjBOLa5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Feb 2023 06:30:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83310F0;
        Wed, 15 Feb 2023 03:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676460656; x=1707996656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w/8TxSnNAH+BRghrAQBoEx6mrAa67WDCH/JQ1gaizsc=;
  b=S/DHfMMTUeBQkNhxynJdgXIdzcwqULztFr8PO6a1vES8YjaJaGxCKuyl
   AzZpG1Z3Bv50YddG2P7zPOIqrxr34hTqqC04cfsT5HDmL7AxRDYVk7cEl
   JG+2y3/0IE0s42ZCIXDatg0jECAYgIjJZxiJqpUTUPXd+hTrT3Qw4GKBn
   UmEaeHKFmEs9KDxP0Sw1kXnaYzg39YQvgInTjOxHoDNSKbk5GFV23cuCJ
   S2W56njlcMkEbY4DSnLqiUIcSY39e2zpg6M5jc4QZYA+hdg0RYtSUorvg
   lj24Z4ybAAOGpHHyZoiWJ6lmDz7Xm33lo4kUeGBtLI7VsdxsVnZaDqgGH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="396027998"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="396027998"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 03:30:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669577083"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="669577083"
Received: from josefgel-mobl.ger.corp.intel.com (HELO [10.251.213.167]) ([10.251.213.167])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 03:30:53 -0800
Message-ID: <836d600a-bb1c-fbb2-89f5-7c79c3150e8c@linux.intel.com>
Date:   Wed, 15 Feb 2023 12:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: Question: partial transfers of DMABUFs
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
References: <53ea4d2db570d3ca514a69015488bd5b849a5193.camel@crapouillou.net>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <53ea4d2db570d3ca514a69015488bd5b849a5193.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hey,

On 2023-02-15 11:48, Paul Cercueil wrote:
> Hi,
>
> I am working on adding support for DMABUFs in the IIO subsystem.
>
> One thing we want there, is the ability to specify the number of bytes
> to transfer (while still defaulting to the DMABUF size).
>
> Since dma_buf_map_attachment() returns a sg_table, I basically have two
> options, and I can't decide which one is the best (or the less ugly):
>
> - Either I add a new API function similar to dmaengine_prep_slave_sg(),
> which still takes a scatterlist as argument but also takes the number
> of bytes as argument;
>
> - Or I add a function to duplicate the scatterlist and then shrink it
> manually, which doesn't sound like a good idea either.
>
> What would be the recommended way?

Does this need an api change? If you create a DMA-BUF of size X, it has 
to be of size X. You can pad with a dummy page probably if you know it 
in advance. But after it has been imported, it cannot change size.

You don´t have to write the entire dma-buf either, so if you want to 
create a 1GB buf and only use the first 4K, that is allowed. The 
contents of  the remainder of the DMA-BUF are undefined. It's up to 
userspace to assign a meaning to it.

I think I'm missing something here that makes the whole question m,ake 
more sense.

~Maarten

