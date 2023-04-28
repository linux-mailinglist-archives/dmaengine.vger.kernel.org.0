Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211A26F1FE8
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 23:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbjD1VAq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 17:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346766AbjD1VAf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 17:00:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7459F7;
        Fri, 28 Apr 2023 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ejLNS2+dkTt6rxvxbLTgcV4zJSUJ4XXIjvSDMNycN9E=; b=uNyGVflBd9wLGE5u5+LKaJ3cjm
        2KNF9ozd4ruP7kD2VLtTbYIUzbjFbe5nlMVy/8VnLlygmWvBd7yi256sJzG+n0AEMXP1lAy34Lc4j
        EfLQVYJOmBqbqTKgPfHotbLATi5R1VxMJPXK0cg/Mi7w/wpeC9U1eRIXTuQJNBkxFomOTUthZCzkS
        kA3Z+tfjeQCpBEn8LWtZDYqoseXudMUBXA2veR9VtaT0i8neCLhsPYPi+wdL63O1ss68+UIYmvBIf
        fcHl5Lhkb9JWsN5i4fxiUCRChekXPemCM/4OitprcQmOv6I+gKbG8+5x1aO5MO7l609PevSK+Tt5/
        DHtKxlpA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psVCG-00BlmB-2S;
        Fri, 28 Apr 2023 21:00:04 +0000
Message-ID: <7f257119-339b-1d42-4252-181f9666d78e@infradead.org>
Date:   Fri, 28 Apr 2023 14:00:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 15/15] crypto: iaa - Add IAA Compression Accelerator
 stats
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
 <20230428205539.113902-16-tom.zanussi@linux.intel.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230428205539.113902-16-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi--

On 4/28/23 13:55, Tom Zanussi wrote:
> diff --git a/drivers/crypto/intel/iaa/Kconfig b/drivers/crypto/intel/iaa/Kconfig
> index fcccb6ff7e29..cffb3a4359fc 100644
> --- a/drivers/crypto/intel/iaa/Kconfig
> +++ b/drivers/crypto/intel/iaa/Kconfig
> @@ -8,3 +8,12 @@ config CRYPTO_DEV_IAA_CRYPTO
>  	  decompression with the Intel Analytics Accelerator (IAA)
>  	  hardware using the cryptographic API.  If you choose 'M'
>  	  here, the module will be called iaa_crypto.
> +
> +config CRYPTO_DEV_IAA_CRYPTO_STATS
> +	bool "Enable Intel(R) IAA Compression Accelerator Statistics"
> +	depends on CRYPTO_DEV_IAA_CRYPTO
> +	default n
> +	help
> +          Enable statistics for the IAA compression accelerator.

The line above should use one tab + 2 spaces for indentation
instead of bunch-of-spaces.

> +	  These include per-device and per-workqueue statistics in
> +	  addition to global driver statistics.

Thanks.
-- 
~Randy
