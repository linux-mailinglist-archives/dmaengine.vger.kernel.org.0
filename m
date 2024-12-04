Return-Path: <dmaengine+bounces-3897-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D769E47C3
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 23:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4682855AF
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 22:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FC81BBBE0;
	Wed,  4 Dec 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTyuHaMC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C5193404
	for <dmaengine@vger.kernel.org>; Wed,  4 Dec 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351000; cv=none; b=InDKjp8HInFL5g+SLlvEUMefvq349UThLE3yRPue7GxKSA+JUGIcdN05WskcBB7wwLMPW3FpTAygN7EqOPawQo2UhnjAs39MQJcqrVX9tAYmyapxw7tVH8661T+/CfdnHGyql/G4oRrYLIDSfyycU9u0h16RJxHYfWyAdKVqOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351000; c=relaxed/simple;
	bh=mOcNGZLwqfc/VlreoZYuG3HNc3J7eKdAVTtTNZv6JFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bv7XCZSSKHrIfgoFHzJIwHmI1hQRReM70b6lkja1iBRz5Ro4kvm16j9j2/M4vs+rnL9tur6Qe3UVwfp6pmnY6iF7jZ6rBoSE3E0FdCju+4jj0hxiRVsh9x/+IbBLOJgFZ1qqFwOkirI3YqPiMDLC4YF30xnXDFuAFnmXmjlZUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTyuHaMC; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e399936829eso441476276.0
        for <dmaengine@vger.kernel.org>; Wed, 04 Dec 2024 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733350997; x=1733955797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+R9VeFcGgeKO7hjf2TbPjl3vVRWh7lcnPItMogoHAw=;
        b=LTyuHaMC4fz/roQYo3X+q/Nbck7QeQf4217TSYIbmdvPOlm4quJSXDvOvsDCVGp8oR
         gvpCSaoeoeta0iB98zG91CNNa6ipf7S7qv5MRk3gUYo7N8W4dTYD866xgRSAkuLKTkk0
         7J8ilxC/OsuSgsnY3WkwdHELZOE8ph+TuVB2a2ZWJljXAedW4/kXZLGB/IHjboGHzvUO
         JBt+G8OSW1EsMDlWc7/fvMx2zYjU/8SqKLQCerZqcqd7Lk7MX9/13J0haFjx8KGAnDmO
         6eYzaJYlD+nwrD4j/HmDGmTWWLJL5QW0sHYLyEvdUap7JU+PP8awwl1+Rs4gwp+MOOE1
         FjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350997; x=1733955797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+R9VeFcGgeKO7hjf2TbPjl3vVRWh7lcnPItMogoHAw=;
        b=AA0iNX6fv9YWzbHXaPKfh0pJUhfwvl9VCjW3AMF45ukmhOJOHzwKheELEu/f6hGnsd
         V5oz4l1rrxqCbM6xQExuOOPDjjpKfvtEEEiUXnn+3mX6XycpQRoi6nt40+/DwjZW3XOa
         48VQoVN3JFAAJcEzWcpT76CDlaSF6tGboCYMUbwOsi5eGkicokke1yJOhIVPngqy0cH4
         VzVvRFQaEDvmWsue/O+7Ep+cpRsKJa1YgB1yFx1N/n09NYnxQN59Rkf/Xzbq1vkPHOIz
         BLFE/Xs2Yx/5PZ1t7ZE8O3hOZXZAndk7T3qeP1SYjRNyNh1fvmftj5Ju9rXudlmNJv8e
         WXdw==
X-Forwarded-Encrypted: i=1; AJvYcCXXJaBcyrO41BQ6rdiHhtQmi2QdoWKlfnNogvPeRfwaKBX7heBCBK7F/Wf83wla9tXdFEGNSGtr+kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbUCfz4X2UMVWHI9k8NzUyICt5wVjrtUp3fsznujvKSqwrh95
	qdiN9h/IyyAP2pA0KAth1oKaaEg4966QA/dOqRmvcy+5lFxDVPmuBz6V13VPXZHUP65Q9N+68/T
	yVbvjvk5ujSer6f9ncm/fDWWn6lImlMwJGVzNqg==
X-Gm-Gg: ASbGnct4tv2zQFJSEMac86eoROkWtTyOxXXm+D5szm0bKWCgHLr9eNWoBGjg0pKUr8u
	g5mcFyQVBwxSrEzKlm1JiZvMy+BMsrQ==
X-Google-Smtp-Source: AGHT+IEd0kN89tDWQ7wSr7iU4SYyIWEHrhFM4RKzg2hOGc586p1+mwASkDY/BWfq4dUAf5CW7UVlXj+CIJ2rv7CFrcM=
X-Received: by 2002:a05:6902:288f:b0:e30:d479:fc55 with SMTP id
 3f1490d57ef6-e39d3a283c0mr9247200276.18.1733350996677; Wed, 04 Dec 2024
 14:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204122059.24239-1-quic_jseerapu@quicinc.com>
 <higpzg6b4e66zpykuu3wlcmaxzplzz3qasoycfytidunp7yqbn@nunjmucxkjbe>
 <052c98ab-1ba4-4665-8b45-3e5ad4fa553b@quicinc.com> <CAA8EJppynecscUbUW7Ue=+oYyhFzftiYVgTc6rEuXbUhpxF7iQ@mail.gmail.com>
 <07f627cd-e5ea-4491-8c3e-2693554e6032@quicinc.com>
In-Reply-To: <07f627cd-e5ea-4491-8c3e-2693554e6032@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 5 Dec 2024 00:23:07 +0200
Message-ID: <CAA8EJppsya+mav+-e6uUmdehk+CEV5vXN3iDaY0kW0sT-243aw@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 15:54, Jyothi Kumar Seerapu
<quic_jseerapu@quicinc.com> wrote:
>
>
>
> On 12/4/2024 7:09 PM, Dmitry Baryshkov wrote:
> > On Wed, 4 Dec 2024 at 15:25, Jyothi Kumar Seerapu
> > <quic_jseerapu@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 12/4/2024 6:15 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Dec 04, 2024 at 05:50:59PM +0530, Jyothi Kumar Seerapu wrote:
> >>>> The DMA TRE(Transfer ring element) buffer contains the DMA
> >>>> buffer address. Accessing data from this address can cause
> >>>> significant delays in SPI transfers, which can be mitigated to
> >>>> some extent by utilizing immediate DMA support.
> >>>>
> >>>> QCOM GPI DMA hardware supports an immediate DMA feature for data
> >>>> up to 8 bytes, storing the data directly in the DMA TRE buffer
> >>>> instead of the DMA buffer address. This enhancement enables faster
> >>>> SPI data transfers.
> >>>>
> >>>> This optimization reduces the average transfer time from 25 us to
> >>>> 16 us for a single SPI transfer of 8 bytes length, with a clock
> >>>> frequency of 50 MHz.
> >>>>
> >>>> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> >>>> ---
> >>>>
> >>>> v2-> v3:
> >>>>      - When to enable Immediate DMA support, control is moved to GPI driver
> >>>>        from SPI driver.
> >>>>      - Optimizations are done in GPI driver related to immediate dma changes.
> >>>>      - Removed the immediate dma supported changes in qcom-gpi-dma.h file
> >>>>        and handled in GPI driver.
> >>>>
> >>>>      Link to v2:
> >>>>       https://lore.kernel.org/all/20241128133351.24593-2-quic_jseerapu@quicinc.com/
> >>>>       https://lore.kernel.org/all/20241128133351.24593-3-quic_jseerapu@quicinc.com/
> >>>>
> >>>> v1 -> v2:
> >>>>      - Separated the patches to dmaengine and spi subsystems
> >>>>      - Removed the changes which are not required for this feature from
> >>>>        qcom-gpi-dma.h file.
> >>>>      - Removed the type conversions used in gpi_create_spi_tre.
> >>>>
> >>>>      Link to v1:
> >>>>       https://lore.kernel.org/lkml/20241121115201.2191-2-quic_jseerapu@quicinc.com/
> >>>>
> >>>>    drivers/dma/qcom/gpi.c | 32 +++++++++++++++++++++++++++-----
> >>>>    1 file changed, 27 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> >>>> index 52a7c8f2498f..35451d5a81f7 100644
> >>>> --- a/drivers/dma/qcom/gpi.c
> >>>> +++ b/drivers/dma/qcom/gpi.c
> >>>> @@ -27,6 +27,7 @@
> >>>>    #define TRE_FLAGS_IEOT             BIT(9)
> >>>>    #define TRE_FLAGS_BEI              BIT(10)
> >>>>    #define TRE_FLAGS_LINK             BIT(11)
> >>>> +#define TRE_FLAGS_IMMEDIATE_DMA     BIT(16)
> >>>>    #define TRE_FLAGS_TYPE             GENMASK(23, 16)
> >>>>
> >>>>    /* SPI CONFIG0 WD0 */
> >>>> @@ -64,6 +65,7 @@
> >>>>
> >>>>    /* DMA TRE */
> >>>>    #define TRE_DMA_LEN                GENMASK(23, 0)
> >>>> +#define TRE_DMA_IMMEDIATE_LEN       GENMASK(3, 0)
> >>>>
> >>>>    /* Register offsets from gpi-top */
> >>>>    #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)     (0x20000 + (0x4000 * (n)) + (0x80 * (k)))
> >>>> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
> >>>>       dma_addr_t address;
> >>>>       struct gpi_tre *tre;
> >>>>       unsigned int i;
> >>>> +    int len;
> >>>> +    u8 immediate_dma;
> >>>>
> >>>>       /* first create config tre if applicable */
> >>>>       if (direction == DMA_MEM_TO_DEV && spi->set_config) {
> >>>> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
> >>>>       tre_idx++;
> >>>>
> >>>>       address = sg_dma_address(sgl);
> >>>> -    tre->dword[0] = lower_32_bits(address);
> >>>> -    tre->dword[1] = upper_32_bits(address);
> >>>> +    len = sg_dma_len(sgl);
> >>>>
> >>>> -    tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
> >>>> +    immediate_dma = (direction == DMA_MEM_TO_DEV) && len <= 2 * sizeof(tre->dword[0]);
> >>>
> >>> inline this condition, remove extra brackets and split the line after &&.
> >> Hi Dmitry Baryshkov, thanks for the review.
> >> Sure, i will make the changes mentioned below. Please let me know otherwise.
> >>
> >> immediate_dma = direction == DMA_MEM_TO_DEV &&
> >>                   len <= 2 * sizeof(tre->dword[0]);
> >
> > I was suggesting to _inline_ this condition rather than having a
> > separate variable for it.
>
> I can directly use the condition as follows:
> if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0]))
>
> However, this condition also needs to account for the
> "TRE_FLAGS_IMMEDIATE_DMA" update. Therefore, I introduced a separate
> variable.
>
> tre->dword[3] |= u32_encode_bits(!!immediate_dma, TRE_FLAGS_IMMEDIATE_DMA);
>
> Please let me know if it's acceptable to mention the entire condition in
> both places instead of using a separate variable.

Move the flag setting under the if() too.

>
>
> >
> >>>> +
> >>>> +    /* Support Immediate dma for write transfers for data length up to 8 bytes */
> >>>> +    if (immediate_dma) {
> >>>> +            /*
> >>>> +             * For Immediate dma, data length may not always be length of 8 bytes,
> >>>> +             * it can be length less than 8, hence initialize both dword's with 0
> >>>> +             */
> >>>> +            tre->dword[0] = 0;
> >>>> +            tre->dword[1] = 0;
> >>>> +            memcpy(&tre->dword[0], sg_virt(sgl), len);
> >>>> +
> >>>> +            tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
> >>>> +    } else {
> >>>> +            tre->dword[0] = lower_32_bits(address);
> >>>> +            tre->dword[1] = upper_32_bits(address);
> >>>> +
> >>>> +            tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
> >>>> +    }
> >>>>
> >>>>       tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> >>>> -    if (direction == DMA_MEM_TO_DEV)
> >>>> -            tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> >>>> +    tre->dword[3] |= u32_encode_bits(!!immediate_dma, TRE_FLAGS_IMMEDIATE_DMA);
> >>>> +    tre->dword[3] |= u32_encode_bits(!!(direction == DMA_MEM_TO_DEV),
> >>>> +                                     TRE_FLAGS_IEOT);
> >>>>
> >>>>       for (i = 0; i < tre_idx; i++)
> >>>>               dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
> >>>> --
> >>>> 2.17.1
> >>>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

