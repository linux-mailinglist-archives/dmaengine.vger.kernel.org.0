Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E7601310
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiJQP5G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 11:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJQP5F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 11:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F013BC61
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666022221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQ9BSUfDKoJUJ+YyUq4v3/jXsEiShgxTQU4ItDdSgGE=;
        b=FrgqxCMeI0Jx89Lh1bEkWzkhEMHlR3pwkVZtvfym9BebjFKpmGOFJfL2mdhvxBsm5fohh5
        d6n837xAmBt4ZKgT/Rt/avHAQUHBOWhI8JvSbLGAwZwwHw5jrH8JOyD+piAOAknYf3V9B2
        JyxzuphofuEHlOWXkPUz+mvJ3GNqy8I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-5WbJRMI9PkqA5J-aVcMi5g-1; Mon, 17 Oct 2022 11:57:00 -0400
X-MC-Unique: 5WbJRMI9PkqA5J-aVcMi5g-1
Received: by mail-qk1-f198.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso10038294qkp.21
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 08:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ9BSUfDKoJUJ+YyUq4v3/jXsEiShgxTQU4ItDdSgGE=;
        b=ujlolg2hjd7IQ9qMJssrYLX4yFrV1wMyIOa5drmU4xje+t+3p3/TuUXutiTZLBJgNb
         gEArkqjCAQT1znHyNVi4HtgLHEenz14NER3oTPoZ8RMgtPwVid2P2JOQ9X310ltS9opF
         34eTmUcNxo7v1R8b6eiNmz5MESWQRPRAF4bzoTj7TfeTrWd3NfNfbKyv1W5uV97wGjO8
         0IWoxBjD5d0R/boTIebHA3lRaSdYIyb+HHZSx9dwoWt18bxbntowFKRKH/8B+aKsJfYM
         +PYWa0LjDQVNdMkOOoKpmaQ1uNAtmlbQYWaQko9M4xdHyFEjQ4G4YwiaFV95B4th6l6Q
         KifQ==
X-Gm-Message-State: ACrzQf3GfP4E8O7jp5MjGWUvIYwHaHR7xbIBTtzGuhLEbA9csS4Lm4Gv
        5MUFuVOZN3tSRB/X44z2EYnLku3I19t+QmQ+oj8s423XUAJQ7X36NMI925CJUWMiYeCrgtYbDg7
        KM8Vj7b/mDqZydlah+WPH
X-Received: by 2002:a05:6214:2aaf:b0:4b1:d684:f724 with SMTP id js15-20020a0562142aaf00b004b1d684f724mr9133430qvb.97.1666022219845;
        Mon, 17 Oct 2022 08:56:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4MXOXDAWK4nrAqUigIaANtf8VLQnL+iRuWPSVrKyXzwp36CNxsgKkJX8PxMceOAIliBF741A==
X-Received: by 2002:a05:6214:2aaf:b0:4b1:d684:f724 with SMTP id js15-20020a0562142aaf00b004b1d684f724mr9133411qvb.97.1666022219641;
        Mon, 17 Oct 2022 08:56:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a0bc900b006cfc4744589sm57440qki.128.2022.10.17.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 08:56:59 -0700 (PDT)
Date:   Mon, 17 Oct 2022 08:56:57 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: Do not enable user type Work Queue
 without Shared Virtual Addressing
Message-ID: <20221017155657.kpwvx5jicitoxbzp@cantor>
References: <20221014222541.3912195-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014222541.3912195-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Oct 14, 2022 at 03:25:41PM -0700, Fenghua Yu wrote:
> When the idxd_user_drv driver is bound to a Work Queue (WQ) device
> without IOMMU or with IOMMU Passthrough without Shared Virtual
> Addressing (SVA), the application gains direct access to physical
> memory via the device by programming physical address to a submitted
> descriptor. This allows direct userspace read and write access to
> arbitrary physical memory. This is inconsistent with the security
> goals of a good kernel API.
> 
> Unlike vfio_pci driver, the IDXD char device driver does not provide any
> ways to pin user pages and translate the address from user VA to IOVA or
> PA without IOMMU SVA. Therefore the application has no way to instruct the
> device to perform DMA function. This makes the char device not usable for
> normal application usage.
> 
> Since user type WQ without SVA cannot be used for normal application usage
> and presents the security issue, bind idxd_user_drv driver and enable user
> type WQ only when SVA is enabled (i.e. user PASID is enabled).
> 
> Fixes: 448c3de8ac83 ("dmaengine: idxd: create user driver for wq 'device'")
> Cc: stable@vger.kernel.org
> Suggested-by: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> v2:
> - Update changlog per Dave Hansen's comments
> 
>  drivers/dma/idxd/cdev.c   | 18 ++++++++++++++++++
>  include/uapi/linux/idxd.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index c2808fd081d6..a9b96b18772f 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -312,6 +312,24 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
>  	if (idxd->state != IDXD_DEV_ENABLED)
>  		return -ENXIO;
>  
> +	/*
> +	 * User type WQ is enabled only when SVA is enabled for two reasons:
> +	 *   - If no IOMMU or IOMMU Passthrough without SVA, userspace
> +	 *     can directly access physical address through the WQ.
> +	 *   - The IDXD cdev driver does not provide any ways to pin
> +	 *     user pages and translate the address from user VA to IOVA or
> +	 *     PA without IOMMU SVA. Therefore the application has no way
> +	 *     to instruct the device to perform DMA function. This makes
> +	 *     the cdev not usable for normal application usage.
> +	 */
> +	if (!device_user_pasid_enabled(idxd)) {
> +		idxd->cmd_status = IDXD_SCMD_WQ_USER_NO_IOMMU;
> +		dev_dbg(&idxd->pdev->dev,
> +			"User type WQ cannot be enabled without SVA.\n");
> +
> +		return -EOPNOTSUPP;
> +	}
> +
>  	mutex_lock(&wq->wq_lock);
>  	wq->type = IDXD_WQT_USER;
>  	rc = drv_enable_wq(wq);
> diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
> index 095299c75828..2b9e7feba3f3 100644
> --- a/include/uapi/linux/idxd.h
> +++ b/include/uapi/linux/idxd.h
> @@ -29,6 +29,7 @@ enum idxd_scmd_stat {
>  	IDXD_SCMD_WQ_NO_SIZE = 0x800e0000,
>  	IDXD_SCMD_WQ_NO_PRIV = 0x800f0000,
>  	IDXD_SCMD_WQ_IRQ_ERR = 0x80100000,
> +	IDXD_SCMD_WQ_USER_NO_IOMMU = 0x80110000,
>  };
>  
>  #define IDXD_SCMD_SOFTERR_MASK	0x80000000
> -- 
> 2.32.0
> 

