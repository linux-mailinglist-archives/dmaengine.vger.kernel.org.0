Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C779E478
	for <lists+dmaengine@lfdr.de>; Wed, 13 Sep 2023 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjIMKCq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Sep 2023 06:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjIMKCp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Sep 2023 06:02:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508119A9
        for <dmaengine@vger.kernel.org>; Wed, 13 Sep 2023 03:02:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso165401166b.1
        for <dmaengine@vger.kernel.org>; Wed, 13 Sep 2023 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694599360; x=1695204160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7fgvd0GgWLe3rd9ZnbjAr4k2YHcBis4i4DpoXfLvsU=;
        b=bLHCzzY627IM2105BCP1MJmXViDo+oSMasPGU0Zd4WmhAG7eSV3r09tIq1xl3KIvsk
         Oho95xvxHzhlpCpHUfbgVQctbewu24WF8APxfJH1fCwgt0ThATau9ALQRpznzDtqcT8j
         ZtFq+mQ378hCa0tCUTeDOVFPWtjPFZtK9JTajF+ZunXcRjP5voaLggols7rCR7RZyx/w
         j2ogAu7BgvonVNe/ZBfleD/DMfg/7NAhtJzDDpuSCwASQgRrYi943P/4h+xKhmpX4fxJ
         maZxEjxj4by9C4gScgN2PIbK2PXYPYnk6T3Et2huNfVS2+40BZoyBu4zuwcxac/hTrdV
         P1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694599360; x=1695204160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7fgvd0GgWLe3rd9ZnbjAr4k2YHcBis4i4DpoXfLvsU=;
        b=XexWrUaKEHE+Tm64WtWABszlSMKnGw2fnJ8hRLgkzwu29CVrMv3cGNWrw0PS7lT+w4
         Bz/8jgY599OeXHakM5Xr6R307lqMuvgP5frigP+QkAqZTaeT3mRZIoDJtpVJD+9WXt2d
         14dvXw4U6x4OyO1RO33hg0IrA8mU1+oeVZ47EY654fFGNYKLNGUxcCBWTqt625ZP4UbP
         PrU2GO7EkLpcxqr2mMNo8WaUiDosqEEA5mzZkMm366WlDCyEJU78GhIdhUVW2UZdHnof
         IwRDLmOLZr3/Thx+6YIdkMH/3ebmQYpeMMUxk/lVWtdNia9A95dWcSSn4RulL2DQ2qj/
         AquA==
X-Gm-Message-State: AOJu0Yz7D373J4AJFtKZzuM/m4YvdaTp30faOme0x4KR9YbBJpw47d/P
        H6PAbF+u99CQFjhePRw7A06tuZj2gi4UsHFeZZc=
X-Google-Smtp-Source: AGHT+IGL5AGZjuJsWQnGYR+Uq1reOUXrWx2BXcplDJspWfko33+t7eicw9/39ECbx90mgMTquejV6A==
X-Received: by 2002:a17:906:1d5:b0:9ad:8641:e91b with SMTP id 21-20020a17090601d500b009ad8641e91bmr5661812ejj.11.1694599359841;
        Wed, 13 Sep 2023 03:02:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ox3-20020a170907100300b0098dfec235ccsm8144684ejb.47.2023.09.13.03.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:02:39 -0700 (PDT)
Message-ID: <60f566f3-7d4a-f074-8f80-e97a19a76d75@linaro.org>
Date:   Wed, 13 Sep 2023 12:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 1/2] dmaengine: Add HiSilicon Ascend SDMA engine
 support
To:     Guo Mengqi <guomengqi3@huawei.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     xuqiang36@huawei.com, chenweilong@huawei.com
References: <20230913082825.3180-1-guomengqi3@huawei.com>
 <20230913082825.3180-2-guomengqi3@huawei.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913082825.3180-2-guomengqi3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13/09/2023 10:28, Guo Mengqi wrote:
> This patch adds a driver for HiSilicon Ascend SDMA engine.
> 
> The DMA controller can do transfers between device and memory
> or memory to memory. Currently, the controller only support
> single copy. Drives can pass a substreamid to the DMA engine,
> which will enable transfers in user-space addresses.
> 
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
> ---
>  drivers/dma/Kconfig            |   9 +
>  drivers/dma/Makefile           |   1 +
>  drivers/dma/hisi-ascend-sdma.c | 810 +++++++++++++++++++++++++++++++++
>  3 files changed, 820 insertions(+)
>  create mode 100644 drivers/dma/hisi-ascend-sdma.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 4ccae1a3b884..afc2b648dcd2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -244,6 +244,15 @@ config FSL_RAID
>  	  the capability to offload memcpy, xor and pq computation
>  	  for raid5/6.
>  
> +config HISI_ASCEND_SDMA
> +	tristate "HiSilicon Ascend SDMA Engine support"
> +	depends on ARCH_HISI && ARM64

Missing compile testing.

> +/*
> + * struct ascend_sdma_chip_data - Ascend chip specific data
> + * @channel_iomem_size: Size of channel register space
> + */
> +struct ascend_sdma_chip_data {
> +	unsigned int channel_iomem_size;
> +};
> +
> +void set_sdma_channel_info(struct dma_chan *c, int pasid);

Why is this needed? There is no usage before definition.

> +
> +static u32 sdma_queue_count(u32 head, u32 tail, u32 len)

Do not declare functions before data structures. You need to properly
organize this code.

> +{
> +	return (tail - head) & (len - 1);
> +}
> +
> +static int iommu_enabled;

No static (file-scope) variables. Drop.

> +
> +struct sdma_sq_entry {
> +	u32 opcode          : 8;
> +	u32 ie              : 1;
> +	u32 sssv            : 1;
> +	u32 dssv            : 1;
> +	u32 sns             : 1;
> +	u32 dns             : 1;
> +	u32 qos             : 4;
> +	u32 sro             : 1;
> +	u32 dro             : 1;
> +	u32 partid          : 4;
> +	u32 mpamns          : 1;
> +	u32 reserved0       : 8;
> +	u32 src_streamid    : 16;
> +	u32 src_substreamid : 16;
> +	u32 dst_streamid    : 16;
> +	u32 dst_substreamid : 16;
> +	u32 length;
> +	union {
> +		u64 src_addr;
> +		struct {
> +			u32 src_addr_l;
> +			u32 src_addr_h;
> +		};
> +	};
> +	union {
> +		u64 dst_addr;
> +		struct {
> +			u32 dst_addr_l;
> +			u32 dst_addr_h;
> +		};
> +	};
> +};
> +
> +struct sdma_cq_entry {
> +	u32 reserved1;
> +	u32 reserved2;
> +	u32 sqhd      : 16;
> +	u32 reserved3 : 16;
> +	u32 reserved4 : 16;
> +	u32 vld       : 1;
> +	u32 status    : 15;
> +};
> +
> +/*
> + * struct sdma_desc - sdma descriptor to manage transfer requests.
> + */
> +struct sdma_desc {
> +	int pasid;
> +	struct virt_dma_desc vd;
> +	struct sdma_sq_entry entry;
> +};
> +
> +/*
> + * struct sdma_chan - sdma channel information
> + */
> +struct sdma_chan {
> +	u16			idx;
> +	u16			cq_vld;
> +
> +	u16			sq_head;
> +	u16			sq_tail;
> +	u16			cq_head;
> +	u16			cq_tail;
> +
> +	/* must be page-aligned and continuous physical memory */
> +	struct sdma_sq_entry	*sq_base;
> +	struct sdma_cq_entry	*cq_base;
> +
> +	/* used for discrete copy, pre-alloc the buffer, reserved for now */
> +	unsigned long		*src_addr;
> +	unsigned long		*dst_addr;
> +	unsigned long		*len;
> +
> +	void __iomem *io_base;
> +
> +	int id;
> +	struct virt_dma_chan vc;
> +	struct sdma_dev *sdev;
> +
> +	struct sdma_desc *desc;
> +	char *name;
> +	int pasid;
> +};
> +
> +#define SDMA_DEVICE_NAME_LENGTH_MAX 20
> +/*
> + * struct sdma_dev - sdma controller information
> + */
> +struct sdma_dev {
> +	struct	dma_device dma_dev;
> +	struct	device	*dev;
> +	void __iomem *io_base;
> +
> +	u16		idx;
> +	u16		nr_channel;

Indentation is a mess.

> +	DECLARE_BITMAP(channel_map, SDMA_MAX_CHANNEL_NUM);
> +	u32		streamid;
> +
> +	const struct ascend_sdma_chip_data *cdata;
> +
> +	char	name[SDMA_DEVICE_NAME_LENGTH_MAX];
> +	struct	sdma_chan *channels;
> +};
> +
> +static inline struct sdma_chan *to_sdma_chan(struct dma_chan *c)
> +{
> +	return container_of(c, struct sdma_chan, vc.chan);
> +}
> +
> +static inline struct sdma_desc *to_sdma_desc(struct virt_dma_desc *vd)
> +{
> +	return container_of(vd, struct sdma_desc, vd);
> +}
> +
> +/* sdma supports sva transfer via iommu.
> + * client must first set the pasid.
> + */
> +void set_sdma_channel_info(struct dma_chan *c, int pasid)

This is not used.

> +{
> +	struct sdma_chan *sc = to_sdma_chan(c);
> +
> +	sc->pasid = pasid;
> +}
> +EXPORT_SYMBOL_GPL(set_sdma_channel_info);

No, you cannot export unused stuff. Drop entire function.

> +
> +struct sdma_hardware_info {
> +	unsigned long	channel_map;
> +	u64		base_addr; /* physical address */
> +};
> +
> +static int of_sdma_collect_info(struct platform_device *pdev, struct sdma_hardware_info *info)

This should be next to probe, not in totally different place.

> +{
> +	int ret;
> +	u32 chan_mask[2] = {0};
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	ret = of_property_read_variable_u32_array(np, "dma-channel-mask",
> +			chan_mask, 1, 2);
> +	if (ret < 0) {
> +		dev_err(dev, "get dma channel mask from dtb failed, %d\n", ret);
> +		return ret;
> +	}
> +	bitmap_from_arr32(&info->channel_map, chan_mask, SDMA_MAX_CHANNEL_NUM);
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	if (ret < 0) {
> +		dev_err(dev, "get io_base info from dtb failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	info->base_addr = res.start;
> +	if (resource_size(&res) != SDMA_IOMEM_SIZE)
> +		dev_warn(dev, "reg size %#llx check failed, use %#x\n",
> +				resource_size(&res), SDMA_IOMEM_SIZE);
> +
> +	return 0;
> +}
> +
> +static int sdma_channel_alloc_sq_cq(struct sdma_chan *sc)
> +{
> +	unsigned long *buf;
> +	struct device *dev = sc->sdev->dev;
> +
> +	sc->sq_base = (struct sdma_sq_entry *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +			get_order(SDMA_SQ_SIZE));
> +	if (!sc->sq_base) {
> +		dev_err(dev, "channel%d: alloc sq_memory failed\n", sc->idx);

Why do you print errors on memory allocation failures?

> +		return -ENOMEM;
> +	}
> +
> +	sc->cq_base = (struct sdma_cq_entry *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +			get_order(SDMA_CQ_SIZE));
> +	if (!sc->cq_base) {
> +		dev_err(dev, "channel%d: alloc cq_memory failed\n", sc->idx);


Same question.

> +		free_pages((unsigned long)sc->sq_base, get_order(SDMA_SQ_SIZE));
> +		return -ENOMEM;
> +	}
> +
> +	buf = vmalloc(sizeof(unsigned long) * SDMA_SQ_LENGTH * 3);
> +	if (!buf) {
> +		dev_err(dev, "channel%d: alloc user_buf failed\n", sc->idx);

Same question.


> +		free_pages((unsigned long)sc->sq_base, get_order(SDMA_SQ_SIZE));
> +		free_pages((unsigned long)sc->cq_base, get_order(SDMA_CQ_SIZE));
> +		return -ENOMEM;
> +	}
> +	sc->src_addr = buf;
> +	sc->dst_addr = buf + SDMA_SQ_LENGTH;
> +	sc->len      = buf + SDMA_SQ_LENGTH * 2;
> +
> +	return 0;
> +}
> +


Best regards,
Krzysztof

