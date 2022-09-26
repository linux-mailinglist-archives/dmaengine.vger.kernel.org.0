Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402B25EAF35
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiIZSH7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiIZSHf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:07:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048B97D64;
        Mon, 26 Sep 2022 10:52:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a14so8316187ljj.8;
        Mon, 26 Sep 2022 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6foHn0OkbFSLWkoYq5bKyci8WiZu5lPR0ZuEYBLeWZA=;
        b=WQp1zat42FR9Lmaq49D/W2S/vHNXvX6xpk+IJ4/mFYVBVyYXCrmCpwqf19zu7u9aqG
         qbGQS55wP+BC7PWmiB8yh5P5JQJvYCq01ZSxcofFJrZXMhFAH4ph2I+kpULJHOjy9mKG
         ALkFf0ImycGVaEE1RwsDz91RPqK+UJaNOLoUCHRrnM9N+26o7r3YPZ8M7HEaned2MUKW
         H0QNSoRllgIf6xn9QmzS01leqnUlOAmANbhGIkxHBA2lNH/cVNn8dY2p2HSxEIIhXGcO
         p2VplAJx4C1nCFY0pYmrhaFFlzBLIy4I8UD22De242ZdmXbKpEW6OF0fcPGJsZ4hNCcT
         FaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6foHn0OkbFSLWkoYq5bKyci8WiZu5lPR0ZuEYBLeWZA=;
        b=bgY3uHggvvPblDAZTLIpR4UFZ+y7WpYUX1LXL8fJEXiRXyf/gyeAqGN7ysfeob4LBA
         Xj8poq3hFG9JQsb+lHDvnBlKDJc0jinmbGGUTh7hMoKe+qYwbNGOEvQgYshLu4KvOITT
         0W5YDea8sbeg3MpnJ4tIBVuzaHqHOA/ebWiE2kyIMciTWU3UKavQanw1XWh5ZAqq6Aby
         1Qqc8Uvs9Ai7uav0CHXPBDRQH6Pz9G4nFs5eD/MAAbjn+5WEuw7IdtX5wVq9+LDgnJx/
         /pU1grtfcnEb2IqymrKsSEH0ANhbw5a+LGEdO0wnt/jcBghJ14C1wNxvbkKlWgmtE8FJ
         gaCw==
X-Gm-Message-State: ACrzQf28x9ABDfFqrx1e4vc/efySfUDxvz0GjWj9DnJ1iohKcCcx9jt0
        qGPWWDXeoVG+o4uErNQVVPoGyJs1qMZYuA==
X-Google-Smtp-Source: AMsMyM7WYXvosPG1AlgxWGO34do+BwAazgzmzm9X1JIwrEJlUGyXXEuHxSM6XZlNvPI2EDJMb52+sw==
X-Received: by 2002:a05:651c:2205:b0:26c:622e:afef with SMTP id y5-20020a05651c220500b0026c622eafefmr8689591ljq.242.1664214724969;
        Mon, 26 Sep 2022 10:52:04 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id t3-20020a056512208300b00492e16b7ab3sm2599999lfr.94.2022.09.26.10.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 10:52:03 -0700 (PDT)
Message-ID: <68297aa6-5ca9-91d9-28de-71e439e3e1c7@gmail.com>
Date:   Mon, 26 Sep 2022 21:00:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dmaengine: ti: edma: Remove some unused functions
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220914101943.83929-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220914101943.83929-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/14/22 13:19, Jiapeng Chong wrote:
> These functions are defined in the edma.c file, but not called elsewhere,
> so delete these unused functions.
> 
> drivers/dma/ti/edma.c:746:31: warning: unused function 'to_edma_cc'.
> drivers/dma/ti/edma.c:420:20: warning: unused function 'edma_param_or'.
> drivers/dma/ti/edma.c:414:20: warning: unused function 'edma_param_and'.
> drivers/dma/ti/edma.c:402:20: warning: unused function 'edma_param_write'.
> drivers/dma/ti/edma.c:373:28: warning: unused function 'edma_shadow0_read'.
> drivers/dma/ti/edma.c:396:28: warning: unused function 'edma_param_read'.
> drivers/dma/ti/edma.c:355:20: warning: unused function 'edma_or_array'.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2152
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/dma/ti/edma.c | 40 ----------------------------------------
>  1 file changed, 40 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 4cbca80ee16e..fa06d7e6d8e3 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -352,12 +352,6 @@ static inline void edma_modify_array(struct edma_cc *ecc, int offset, int i,
>  	edma_modify(ecc, offset + (i << 2), and, or);
>  }
>  
> -static inline void edma_or_array(struct edma_cc *ecc, int offset, int i,
> -				 unsigned or)
> -{
> -	edma_or(ecc, offset + (i << 2), or);
> -}
> -
>  static inline void edma_or_array2(struct edma_cc *ecc, int offset, int i, int j,
>  				  unsigned or)
>  {
> @@ -370,11 +364,6 @@ static inline void edma_write_array2(struct edma_cc *ecc, int offset, int i,
>  	edma_write(ecc, offset + ((i * 2 + j) << 2), val);
>  }
>  
> -static inline unsigned int edma_shadow0_read(struct edma_cc *ecc, int offset)
> -{
> -	return edma_read(ecc, EDMA_SHADOW0 + offset);
> -}
> -
>  static inline unsigned int edma_shadow0_read_array(struct edma_cc *ecc,
>  						   int offset, int i)
>  {
> @@ -393,36 +382,12 @@ static inline void edma_shadow0_write_array(struct edma_cc *ecc, int offset,
>  	edma_write(ecc, EDMA_SHADOW0 + offset + (i << 2), val);
>  }
>  
> -static inline unsigned int edma_param_read(struct edma_cc *ecc, int offset,
> -					   int param_no)
> -{
> -	return edma_read(ecc, EDMA_PARM + offset + (param_no << 5));
> -}
> -
> -static inline void edma_param_write(struct edma_cc *ecc, int offset,
> -				    int param_no, unsigned val)
> -{
> -	edma_write(ecc, EDMA_PARM + offset + (param_no << 5), val);
> -}
> -
>  static inline void edma_param_modify(struct edma_cc *ecc, int offset,
>  				     int param_no, unsigned and, unsigned or)
>  {
>  	edma_modify(ecc, EDMA_PARM + offset + (param_no << 5), and, or);
>  }
>  
> -static inline void edma_param_and(struct edma_cc *ecc, int offset, int param_no,
> -				  unsigned and)
> -{
> -	edma_and(ecc, EDMA_PARM + offset + (param_no << 5), and);
> -}
> -
> -static inline void edma_param_or(struct edma_cc *ecc, int offset, int param_no,
> -				 unsigned or)
> -{
> -	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
> -}
> -
>  static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
>  					  int priority)
>  {
> @@ -743,11 +708,6 @@ static void edma_free_channel(struct edma_chan *echan)
>  	edma_setup_interrupt(echan, false);
>  }
>  
> -static inline struct edma_cc *to_edma_cc(struct dma_device *d)
> -{
> -	return container_of(d, struct edma_cc, dma_slave);
> -}
> -
>  static inline struct edma_chan *to_edma_chan(struct dma_chan *c)
>  {
>  	return container_of(c, struct edma_chan, vchan.chan);

-- 
Péter
