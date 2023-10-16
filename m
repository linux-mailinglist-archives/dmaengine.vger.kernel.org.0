Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4B7CA692
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 13:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjJPLTg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 07:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJPLTf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 07:19:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD7B4
        for <dmaengine@vger.kernel.org>; Mon, 16 Oct 2023 04:19:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso44416435e9.3
        for <dmaengine@vger.kernel.org>; Mon, 16 Oct 2023 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697455172; x=1698059972; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAESKt1/T3GVQGNnRZWVrNLSksasl+lznfCvKDEPwao=;
        b=UDojpBF/iTtTD74S5vIkQixtvxWr6UGJxQKxalVxVsSxz4G+5eJi+1fsDVizpWpo5u
         lXPTslrFMOTFNCWOZgGfcn7IV0KHYTSiHraYe799JeXZpaq6rk3DN0Hnje++P85tV3HC
         3hsetIVMZRj5+/6HlOCC8p2nWMxKRxgJtnlGr9WV2TL28Q/qDeyrB84zONZXCY6Uj+fY
         +UgKo/ISLKyzcBuZ+Ihp62tdd9OHxExBe5h2QeMB9bK02+g6yghYOVn7RJn8GAcFLwgp
         fP4lcDvdBC0DtfthE+Eyj3MzLNAzg4yp1+OzHfeQwI6qgz9hehwm5PdfWC4WKGWZidy4
         s8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697455172; x=1698059972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAESKt1/T3GVQGNnRZWVrNLSksasl+lznfCvKDEPwao=;
        b=QhCQxFZ1h+Wlt1wFAJHuAXdGgILZn23O5Mk5pNlTk3HiRWKkycpG4P/OFAjSguLa+L
         7cfFVp7Awgm4zhmNuKaseLpp20+GrWWG5Yit6M2iE6j+jqSHfDKjRDJAPQsMJywmL/PX
         3IlrMWw2rXfEKlbfP97egBfVk8bRJYFa9PMZnEyQ8nDGpTHORMyF1VtBAxHC7D7QhmWF
         T7DGO6PbnEZCruFRVfNR1cyJ4BojQk7LPyYkuuf7U+bC9S4Q2wPJG6n1/Q+OvYVZon5G
         1uQ/KbPnRWe1BSO2x0bMYu4n2h5rjvObIhQ6dNiDcSKXQngk9VmmXnxeamoUK+Hw0kTH
         7JzQ==
X-Gm-Message-State: AOJu0Yx5hZGTqra/jltTN7/5IEHopmb07MS5cQKLIeINIlBYyq8vSmuW
        LgoR13BH/GVZ9pZpHXLWxD2ZV21/1DiEs/TxGq8=
X-Google-Smtp-Source: AGHT+IFXLn6HVAkJUUvFhoWtP7PoWPk63M+RF0eXFs4sNfYDLfw1h2sjM+ygaKtTEAenciun42rqrA==
X-Received: by 2002:a05:600c:3ba1:b0:406:872d:7725 with SMTP id n33-20020a05600c3ba100b00406872d7725mr28577118wms.1.1697455171974;
        Mon, 16 Oct 2023 04:19:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b0040535648639sm6892615wmo.36.2023.10.16.04.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:19:31 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:19:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     tudor.ambarus@linaro.org
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: at_hdmac: Convert driver to use virt-dma
Message-ID: <921652fc-d33a-4bf9-8bec-4fbee0f6842b@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Tudor Ambarus,

The patch ac803b56860f: "dmaengine: at_hdmac: Convert driver to use
virt-dma" from Oct 25, 2022 (linux-next), leads to the following
Smatch static checker warning:

drivers/dma/at_hdmac.c:1036 atc_prep_dma_memcpy() warn: pointer dereferenced without being set 'desc->vd.tx.chan'
drivers/dma/at_hdmac.c:1223 atc_prep_dma_memset_sg() warn: pointer dereferenced without being set 'desc->vd.tx.chan'
drivers/dma/at_hdmac.c:1387 atc_prep_slave_sg() warn: pointer dereferenced without being set 'desc->vd.tx.chan'
drivers/dma/at_hdmac.c:1543 atc_prep_dma_cyclic() warn: pointer dereferenced without being set 'desc->vd.tx.chan'
drivers/dma/at_xdmac.c:1499 at_xdmac_prep_dma_memset_sg() warn: pointer dereferenced without being set 'psg'

drivers/dma/at_hdmac.c
    960 static struct dma_async_tx_descriptor *
    961 atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
    962                 size_t len, unsigned long flags)
    963 {
    964         struct at_dma                *atdma = to_at_dma(chan->device);
    965         struct at_dma_chan        *atchan = to_at_dma_chan(chan);
    966         struct at_desc                *desc = NULL;
    967         size_t                        xfer_count;
    968         size_t                        offset;
    969         size_t                        sg_len;
    970         unsigned int                src_width;
    971         unsigned int                dst_width;
    972         unsigned int                i;
    973         u32                        ctrla;
    974         u32                        ctrlb;
    975 
    976         dev_dbg(chan2dev(chan), "prep_dma_memcpy: d%pad s%pad l0x%zx f0x%lx\n",
    977                 &dest, &src, len, flags);
    978 
    979         if (unlikely(!len)) {
    980                 dev_err(chan2dev(chan), "prep_dma_memcpy: length is zero!\n");
    981                 return NULL;
    982         }
    983 
    984         sg_len = DIV_ROUND_UP(len, ATC_BTSIZE_MAX);
    985         desc = kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
    986         if (!desc)
    987                 return NULL;
    988         desc->sglen = sg_len;
    989 
    990         ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
    991                 FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_INCR) |
    992                 FIELD_PREP(ATC_DST_ADDR_MODE, ATC_DST_ADDR_MODE_INCR) |
    993                 FIELD_PREP(ATC_FC, ATC_FC_MEM2MEM);
    994 
    995         /*
    996          * We can be a lot more clever here, but this should take care
    997          * of the most common optimization.
    998          */
    999         src_width = dst_width = atc_get_xfer_width(src, dest, len);
    1000 
    1001         ctrla = FIELD_PREP(ATC_SRC_WIDTH, src_width) |
    1002                 FIELD_PREP(ATC_DST_WIDTH, dst_width);
    1003 
    1004         for (offset = 0, i = 0; offset < len;
    1005              offset += xfer_count << src_width, i++) {
    1006                 struct atdma_sg *atdma_sg = &desc->sg[i];
    1007                 struct at_lli *lli;
    1008 
    1009                 atdma_sg->lli = dma_pool_alloc(atdma->lli_pool, GFP_NOWAIT,
    1010                                                &atdma_sg->lli_phys);
    1011                 if (!atdma_sg->lli)
    1012                         goto err_desc_get;
    1013                 lli = atdma_sg->lli;
    1014 
    1015                 xfer_count = min_t(size_t, (len - offset) >> src_width,
    1016                                    ATC_BTSIZE_MAX);
    1017 
    1018                 lli->saddr = src + offset;
    1019                 lli->daddr = dest + offset;
    1020                 lli->ctrla = ctrla | xfer_count;
    1021                 lli->ctrlb = ctrlb;
    1022 
    1023                 desc->sg[i].len = xfer_count << src_width;
    1024 
    1025                 atdma_lli_chain(desc, i);
    1026         }
    1027 
    1028         desc->total_len = len;
    1029 
    1030         /* set end-of-link to the last link descriptor of list*/
    1031         set_lli_eol(desc, i - 1);
    1032 
    1033         return vchan_tx_prep(&atchan->vc, &desc->vd, flags);

Before this point desc->vd.tx.chan is NULL.


    1034 
    1035 err_desc_get:
--> 1036         atdma_desc_free(&desc->vd);

This dereferences desc->vd.tx.chan so it will crash.  The other warnings
are similar except for the "psg" one.  That one will only crash if
"sg_len" is 1.

    1037         return NULL;
    1038 }

regards,
dan carpenter
