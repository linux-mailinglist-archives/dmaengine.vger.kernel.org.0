Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05A671C44
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 13:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjARMkJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 07:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjARMiI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 07:38:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F434B1BC;
        Wed, 18 Jan 2023 04:02:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74CEFCE1C35;
        Wed, 18 Jan 2023 12:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0396FC433D2;
        Wed, 18 Jan 2023 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674043353;
        bh=4Xca03zRSlvGRCTu93+PKQ1DoyTUuno9kJ8y0NpugwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPtHVR/YK4UMN28qZMbEoTcnPhmInV/4V9edRsb11BNvbtkINkpgnCe4rLbA8/Myp
         +XXZRgA8YkOKgl/X+CE+NodmxnT9INRKRB8QiPwyloWOfzfV+CV8nTR0579dJc15nX
         WQPjHNyaT+fQe3pCltpzBiBw89b5/8+9/oHqLQGBWpZYuA0WvhPhBovvIiw4OOpG75
         oJu4BJ9Zp4t06IcZVNgzLl4TzkjCIepaY5iK4kbN2fMJXW0qPv+Vw+oHpVNtLsXUKY
         wGx+rLWLFDakorKpF9h8czOaeu9EBRkDLXRSwTPUNidzvr9JIX6VHhdr/DHqxTXCft
         nmw7/DxXlQU1A==
Date:   Wed, 18 Jan 2023 17:32:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dmaengine: idxd: reformat swerror output to standard
 Linux bitmap output
Message-ID: <Y8ff1R7O0uKTFN15@matsya>
References: <20230103165337.1570238-1-fenghua.yu@intel.com>
 <20230103165337.1570238-2-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103165337.1570238-2-fenghua.yu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-01-23, 08:53, Fenghua Yu wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> SWERROR register is 4 64bit wide registers. Currently the sysfs attribute
> just outputs 4 64bit hex integers. Covert to output with %*pb format

s/Covert/Convert

> specifier.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/dma/idxd/idxd.h  |  1 +
>  drivers/dma/idxd/init.c  |  2 +-
>  drivers/dma/idxd/sysfs.c | 10 ++++------
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index f92f8ec83722..e449d905bea3 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -654,6 +654,7 @@ int idxd_register_driver(void);
>  void idxd_unregister_driver(void);
>  void idxd_wqs_quiesce(struct idxd_device *idxd);
>  bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
> +void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);

This change does not belong to this patch, I dont know why this is here

>  
>  /* device interrupt control */
>  irqreturn_t idxd_misc_thread(int vec, void *data);
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 564c025b9b7e..996bd3e4e50f 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -425,7 +425,7 @@ static void idxd_read_table_offsets(struct idxd_device *idxd)
>  	dev_dbg(dev, "IDXD Perfmon Offset: %#x\n", idxd->perfmon_offset);
>  }
>  
> -static void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count)
> +void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count)
>  {
>  	int i, j, nr;
>  
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index c772172d4ceb..dae28509e6ed 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1506,15 +1506,13 @@ static ssize_t errors_show(struct device *dev,
>  			   struct device_attribute *attr, char *buf)
>  {
>  	struct idxd_device *idxd = confdev_to_idxd(dev);
> -	int i, out = 0;
> +	DECLARE_BITMAP(swerr_bmap, 256);
>  
> +	bitmap_zero(swerr_bmap, 256);
>  	spin_lock(&idxd->dev_lock);
> -	for (i = 0; i < 4; i++)
> -		out += sysfs_emit_at(buf, out, "%#018llx ", idxd->sw_err.bits[i]);
> +	multi_u64_to_bmap(swerr_bmap, &idxd->sw_err.bits[0], 4);
>  	spin_unlock(&idxd->dev_lock);
> -	out--;
> -	out += sysfs_emit_at(buf, out, "\n");
> -	return out;
> +	return sysfs_emit(buf, "%*pb\n", 256, swerr_bmap);
>  }
>  static DEVICE_ATTR_RO(errors);
>  
> -- 
> 2.32.0

-- 
~Vinod
