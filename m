Return-Path: <dmaengine+bounces-4456-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09477A33AE6
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2025 10:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DF5188E768
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2025 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E257D20FAA8;
	Thu, 13 Feb 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr3ugRme"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA220CCFB
	for <dmaengine@vger.kernel.org>; Thu, 13 Feb 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438048; cv=none; b=eWGoE0zqom5scaa3i54nmuoGrkWuy9ePDteXIoVmEF0tLPUaHPxAF4DSYGM6k+Mvew4Ip9P0tMmWS0Ob6cg4fuEYzB3EfguBO5HliZwgT6zBNmTRhS9HMHagK0/OPZQ2bqjXi2AZH8jSJM5X4So4vAwf0AFYjkac5A7IDpOlmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438048; c=relaxed/simple;
	bh=30HWgi7vTsnHsMHIdE9kQ0IaMR5R8G7DHrbFokXG3po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQbnCrsk2mO9WL9U3PbD9x/pRfHO+1XenwVi7OoMg6zLlKyT9EtbfFXBIKHEqcGzQVaAQHe2R4K/iN9aP3cVn3AjaA5k0AaG49m1BIjQ7cyQab17BdNbIbfpNIXSddUhRyXjMCYhEcLF0cro9jBoSWoS+qSrvG6nxVaoD/hxKVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dr3ugRme; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab771575040so352802366b.1
        for <dmaengine@vger.kernel.org>; Thu, 13 Feb 2025 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739438042; x=1740042842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AuG/ss21p8Rkezi+mFzCeDZN/8oyjr+HjN6pWHmLEY=;
        b=Dr3ugRmebrnC2hRm9FahoJIPS0D6CYzTWwyKiQBNVGFoTKvRzbdBB2R4CSYxsHu4T+
         vZtg0BltQlFT9bkmWnygmJDRSy5Wb/LSDg6JdbLYltgqNgwq+yr1bIQ2c+tG0jD3zOWE
         l8tgeM6AcZ7ojdjIgk484xBz+CxSejbj1yWIcQ9w1D34S79Op3czk/FS0vV1oLXcXrgp
         w1VwhiTr0jhmp/Qv+i5MSjFyLLSn2FoJ3vP9wIHmASatD4Pw+dsIx6Io8QI7N7iuwIcg
         l3fF+SwLIHG4WyPOiET5wWV0+3lolAhw6fbr/V7w0ZuEy5HzSXs278F73Hz7NTBk+9kr
         t2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438042; x=1740042842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AuG/ss21p8Rkezi+mFzCeDZN/8oyjr+HjN6pWHmLEY=;
        b=NjnOJSwdVjT8K92VArXJ2Bba0IE7CTP9ZZ53ha8ECzgj9yZWtXGdgHc3IW1YcKPK2G
         iTD6AWBejUv8gfmcmDCpRA2dOTwjfUmqPa9HsK8lkC369oUKnXzgpG09qucf0OmvqUGz
         pqWIn080m/JGmlRzI4SSYfmuw97OTrXsA0WXZj+bergpYJs2egWamNJroTZo1WY1HRQh
         2Sl81culX4k1xq9VXIOxSp4uZDVM8MA0J4EQePYu0xTWfwe3npELrzFb5/BjaahYLr3P
         /bsoaOp4grng/yCoCpw8bXJIrnFFdTKEVXWgbtqjCOdg8O3b4NL9Vo2gqicLL38i+PUc
         HDLA==
X-Forwarded-Encrypted: i=1; AJvYcCWCZMDtgPhrLQlx6idM9gctf1bYe6zyGki4vjOXQ02Ezm1EYHzhKGTLpz7HefTRM87r56O4cRppo/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCMPX6Q25qJlpOgif3Ntis1X3CiQzeiusvWJk+NIoC28z81Sd
	cz5N6WQANg/5eNKth/YQ/70PjYU0+jpdPmhGXcqVN0kcYrxiw1fzddS7cu8/PeQ=
X-Gm-Gg: ASbGnctgXhhBMmSNIuZQKDEw4hy4/GAzdv0VfgLaHTrQo91U71NNiT//XMzW/tzEoew
	qmGJRJnd44pZTcjWryLJKpWgr3DqPt88fjwbCnNQraVTaF36JFX9ya5DADYDe1xb0ZoRcCY0Vb1
	6pCWOeg1/lVJUlPS746RBuIWVvPQnC4baCWdtTmFr0IJYlxCAgbDmYwTWfdOhYr0LAAFW08G1Cs
	7TFM5wNAIUddg1yEPepynUt/qLYfZVGPUdioEiqHwEGEtdJ2wRI17qR5QOfCEyfLSj5r7rpcaIj
	2qw2GgfK0RlswspRhArLcaUd
X-Google-Smtp-Source: AGHT+IEXo2jU1kEu8aaOTnhvjItCP8ixDD0lckNHArfb/LW2ZwYI68wZOQsDjd228D5rNwIDkn/ZhA==
X-Received: by 2002:a17:907:3dab:b0:ab7:d66f:c872 with SMTP id a640c23a62f3a-aba51503279mr194336266b.19.1739438042352;
        Thu, 13 Feb 2025 01:14:02 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:546e:a2d:e86:b3d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322dbsm91900266b.10.2025.02.13.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:14:01 -0800 (PST)
Date: Thu, 13 Feb 2025 10:13:57 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 7/8] dt-bindings: dma: qcom: bam-dma: Add missing
 required properties
Message-ID: <Z6231bBqNhA2M4Ap@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
 <20250212-bam-dma-fixes-v1-7-f560889e65d8@linaro.org>
 <22ce4c8d-1f3b-42c9-b588-b7d74812f7b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ce4c8d-1f3b-42c9-b588-b7d74812f7b0@oss.qualcomm.com>

On Wed, Feb 12, 2025 at 10:01:59PM +0100, Konrad Dybcio wrote:
> On 12.02.2025 6:03 PM, Stephan Gerhold wrote:
> > num-channels and qcom,num-ees are required when there are no clocks
> > specified in the device tree, because we have no reliable way to read them
> > from the hardware registers if we cannot ensure the BAM hardware is up when
> > the device is being probed.
> > 
> > This has often been forgotten when adding new SoC device trees, so make
> > this clear by describing this requirement in the schema.
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > index 3ad0d9b1fbc5e4f83dd316d1ad79773c288748ba..5f7e7763615578717651014cfd52745ea2132115 100644
> > --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > @@ -90,8 +90,12 @@ required:
> >  anyOf:
> >    - required:
> >        - qcom,powered-remotely
> > +      - num-channels
> > +      - qcom,num-ees
> >    - required:
> >        - qcom,controlled-remotely
> > +      - num-channels
> > +      - qcom,num-ees
> 
> I think I'd rather see these deprecated and add the clock everywhere..
> Do we know which one we need to add on newer platforms? Or maybe it's
> been transformed into an icc path?

This isn't feasible, there are too many different setups. Also often the
BAM power management is tightly integrated into the consumer interface.
To give a short excerpt (I'm sure there are even more obscure uses):

 - BLSP BAM (UART, I2C, SPI on older SoCs):
    1. Enable GCC_BLSP_AHB_CLK
    -> This is what the bam_dma driver supports currently.

 - Crypto BAM: Either
    OR 1. Vote for single RPM clock
    OR 1. Enable 3 separate clocks (CE, CE_AHB, CE_AXI)
    OR 1. Vote dummy bandwidth for interconnect

 - BAM DMUX (WWAN on older SoCs):
    1. Start modem firmware
    2. Wait for BAM DMUX service to be up
    3. Vote for power up via the BAM-DMUX-specific SMEM state
    4. Hope the firmware agrees and brings up the BAM

 - SLIMbus BAM (audio on some SoCs):
    1. Start ADSP firmware
    2. Wait for QMI SLIMBUS service to be up via QRTR
    3. Vote for power up via SLIMbus-specific QMI messages
    4. Hope the firmware agrees and brings up the BAM

Especially for the last two, we can't implement support for those
consumer-specific interfaces in the BAM driver. Implementing support for
the 3 variants of the Crypto BAM would be possible, but it's honestly
the least interesting use case of all these. It's not really clear why
we are bothing with the crypto engine on newer SoCs at all, see e.g. [1].

[1]: https://lore.kernel.org/linux-arm-msm/20250118080604.GA721573@sol.localdomain/

> Reading back things from this piece of HW only to add it to DT to avoid
> reading it later is a really messy solution.

In retrospect, it could have been cleaner to avoid describing the BAM as
device node independent of the consumer. We wouldn't have this problem
if the BAM driver would only probe when the consumer is already ready.

But I think specifying num-channels in the device tree is the cleanest
way out of this mess. I have a second patch series ready that drops
qcom,num-ees and validates the num-channels once it's safe reading from
the BAM registers. That way, you just need one boot test to ensure the
device tree description is really correct.

Thanks,
Stephan

