Return-Path: <dmaengine+bounces-4544-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB28EA3D62A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 11:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF222170B19
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41A1F0E29;
	Thu, 20 Feb 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbnxBlwP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F041F03CA
	for <dmaengine@vger.kernel.org>; Thu, 20 Feb 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046185; cv=none; b=cruPtuB3cubbjEugk+O4p51pT/AgpmBzL7lUEQydf0wnq3ii9K8lhJ626Cu9hoZuGorGS3nqnSYELuCtdceD2bxZ1yBpqmLk6E8UgMGB7QSj2rG8Bayjw9sHN/UUVbyATTLxtOAfvOfiD6SMjJFod2FUogbS2TrQLKd/lnLP55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046185; c=relaxed/simple;
	bh=Zoo9uQ8Drs94E3LT5wK9nBC48YVNSJ75dwbnTzaoVHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtXF3dPj/Or5VaAtk8PL2gixCn8n4n/VJR6H+nkPIoGuC1U+vgmkKhVb4ladRmDkZebUlGJ7DSt6zDU2JyUlULIpetkQbcdXImYYij0v0K8U+8ZKTAi30DZUotbnHPJpsZlg0x68UZu7JZ2077teywmJfsDLbXXzrBDc9l6358k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TbnxBlwP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f488f3161so327513f8f.3
        for <dmaengine@vger.kernel.org>; Thu, 20 Feb 2025 02:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740046181; x=1740650981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKAFazs0bK/4Q6jQNje2L8Expu/NOgNPeCn90wFFS4o=;
        b=TbnxBlwPjjyp5w4jK7dHSTOLWZ2jty0K7BW6YS3sGDpseukWSP+NfndN8IXkZbspVn
         y/2hRbyjkA7okR7Npwye0REGht+j8z4kKPj++qi+dFBcIwmBfBx11ZwI93N+aq7BWRY7
         4MUHHO+fzvDRFoIqRGAsRaY4GmlMbuvHA/Yx8dxKTVQ744Y/oGu+NlhUmvY9jQOHx6GU
         XWw5cnlAmw1B2bOx1iRckt9Zla4faaKXtB9VzVCZISstygkJR3MziNB2CaSZT8DsLrQD
         DwYHFgSgJVm0l/J9lVq4/1wtcJS50Kie/9SNSysy8thpkUl4RigzHFMAVxMnz6xfuVx5
         AK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046181; x=1740650981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKAFazs0bK/4Q6jQNje2L8Expu/NOgNPeCn90wFFS4o=;
        b=XkyhX7g6hriWcl56tznyRN/EyzEGEnebbUQ0pTd2Kuu5XcEkIFdz/CTiNH78Lq02oh
         1VGK2AzTEGQNYtvA7xMEI3iY5A8bvGdbYIGPouJGZCKYukMnAfr8i79ghffzc9G0B9au
         ZH3XQTFXYqeGK3MJUnAtZFc8J2vXaS9ZFumtZ/+D9RH3Jj2Vx/GesM4QAvcM5oYdcumi
         RJ82tJuNgE3zAmmCRs0rawf9HnPUWbYUE3tglWRxubj5R06eb/1JMGLKeRjebz9WpcQ7
         BLVWwTB8tRbd+6OAaByNNdoIAXAF7xkVddT/QJf9zE+q8fQx8zv0UW++e+YRbwm9T/lX
         Nqxw==
X-Forwarded-Encrypted: i=1; AJvYcCWWWQz5kydxTYq5Aal7zg/Ihmd5qwnjd2I0AR6AGhv4q1LeEtLZCJOVMOqeDeAGVuryW2009S30mxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytpHnlOPPhNv2WZ4jhc2qG+MqNEtbok8MkvR3v76gs67oTEErK
	LET0mVzSn5V9LU4KaFb+4//D7qM8m30OemsKCaJ912TU6eB8LcsdiI6CaGuku+Y=
X-Gm-Gg: ASbGnct5hEhp4YXc6LWEBB1tHERYteW1iZw8hx7iEJp4xPIyEys0iCcZdOUQb7yZJUV
	vZ2nuXi0Q1xU+rVvLvAsfGoW3VCb1c67eteeWXgZdEyk/0AECGp+fO9a1tgZADsSNuZMCegnP9K
	U5NSozPOaJWDgMcINfoJdIyrhX28IKhKXyBLcNPgSAXQpFaYDuyrptCLps7aMLaSD8sptq1V5ze
	V5M21eGCpGyql5mI1XCretn7loZcCdYqLFWJyvYIHIsCcrBmdijvWdlepiBvJawmc1VwusBk4iS
	6ffXOy6ozxtbHCFJy8gmNR94hVw=
X-Google-Smtp-Source: AGHT+IERc6hIPqaeWn2CPZBGtZZAAoxkqyWFInBWc9QDvWlSHwq2D21AKF4IMfL83X3LHVGKdeB0Yw==
X-Received: by 2002:a5d:59a2:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38f33f437fdmr19446268f8f.42.1740046181176;
        Thu, 20 Feb 2025 02:09:41 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:b30c:3d94:4d4a:a6eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4123sm20741585f8f.17.2025.02.20.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:09:40 -0800 (PST)
Date: Thu, 20 Feb 2025 11:09:38 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
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
Message-ID: <Z7b_YgzGJUT_un5z@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
 <20250212-bam-dma-fixes-v1-7-f560889e65d8@linaro.org>
 <22ce4c8d-1f3b-42c9-b588-b7d74812f7b0@oss.qualcomm.com>
 <Z6231bBqNhA2M4Ap@linaro.org>
 <d674d626-e6a3-4683-8f45-81b09200849f@oss.qualcomm.com>
 <Z64OKcj9Ns1NkUea@linaro.org>
 <20250219222739.GA3078392-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219222739.GA3078392-robh@kernel.org>

On Wed, Feb 19, 2025 at 04:27:39PM -0600, Rob Herring wrote:
> On Thu, Feb 13, 2025 at 04:22:17PM +0100, Stephan Gerhold wrote:
> > On Thu, Feb 13, 2025 at 03:00:00PM +0100, Konrad Dybcio wrote:
> > > On 13.02.2025 10:13 AM, Stephan Gerhold wrote:
> > > > On Wed, Feb 12, 2025 at 10:01:59PM +0100, Konrad Dybcio wrote:
> > > >> On 12.02.2025 6:03 PM, Stephan Gerhold wrote:
> > > >>> num-channels and qcom,num-ees are required when there are no clocks
> > > >>> specified in the device tree, because we have no reliable way to read them
> > > >>> from the hardware registers if we cannot ensure the BAM hardware is up when
> > > >>> the device is being probed.
> > > >>>
> > > >>> This has often been forgotten when adding new SoC device trees, so make
> > > >>> this clear by describing this requirement in the schema.
> > > >>>
> > > >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > >>> ---
> > > >>>  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 ++++
> > > >>>  1 file changed, 4 insertions(+)
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > > >>> index 3ad0d9b1fbc5e4f83dd316d1ad79773c288748ba..5f7e7763615578717651014cfd52745ea2132115 100644
> > > >>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > > >>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > > >>> @@ -90,8 +90,12 @@ required:
> > > >>>  anyOf:
> > > >>>    - required:
> > > >>>        - qcom,powered-remotely
> > > >>> +      - num-channels
> > > >>> +      - qcom,num-ees
> > > >>>    - required:
> > > >>>        - qcom,controlled-remotely
> > > >>> +      - num-channels
> > > >>> +      - qcom,num-ees
> > > >>
> > > >> I think I'd rather see these deprecated and add the clock everywhere..
> > > >> Do we know which one we need to add on newer platforms? Or maybe it's
> > > >> been transformed into an icc path?
> > > > 
> > > > This isn't feasible, there are too many different setups. Also often the
> > > > BAM power management is tightly integrated into the consumer interface.
> > > > To give a short excerpt (I'm sure there are even more obscure uses):
> > > > 
> > > >  - BLSP BAM (UART, I2C, SPI on older SoCs):
> > > >     1. Enable GCC_BLSP_AHB_CLK
> > > >     -> This is what the bam_dma driver supports currently.
> > > > 
> > > >  - Crypto BAM: Either
> > > >     OR 1. Vote for single RPM clock
> > > >     OR 1. Enable 3 separate clocks (CE, CE_AHB, CE_AXI)
> > > >     OR 1. Vote dummy bandwidth for interconnect
> > > > 
> > > >  - BAM DMUX (WWAN on older SoCs):
> > > >     1. Start modem firmware
> > > >     2. Wait for BAM DMUX service to be up
> > > >     3. Vote for power up via the BAM-DMUX-specific SMEM state
> > > >     4. Hope the firmware agrees and brings up the BAM
> > > > 
> > > >  - SLIMbus BAM (audio on some SoCs):
> > > >     1. Start ADSP firmware
> > > >     2. Wait for QMI SLIMBUS service to be up via QRTR
> > > >     3. Vote for power up via SLIMbus-specific QMI messages
> > > >     4. Hope the firmware agrees and brings up the BAM
> > > > 
> > > > Especially for the last two, we can't implement support for those
> > > > consumer-specific interfaces in the BAM driver. Implementing support for
> > > > the 3 variants of the Crypto BAM would be possible, but it's honestly
> > > > the least interesting use case of all these. It's not really clear why
> > > > we are bothing with the crypto engine on newer SoCs at all, see e.g. [1].
> > > > 
> > > > [1]: https://lore.kernel.org/linux-arm-msm/20250118080604.GA721573@sol.localdomain/
> > > > 
> > > >> Reading back things from this piece of HW only to add it to DT to avoid
> > > >> reading it later is a really messy solution.
> > > > 
> > > > In retrospect, it could have been cleaner to avoid describing the BAM as
> > > > device node independent of the consumer. We wouldn't have this problem
> > > > if the BAM driver would only probe when the consumer is already ready.
> > > > 
> > > > But I think specifying num-channels in the device tree is the cleanest
> > > > way out of this mess. I have a second patch series ready that drops
> > > > qcom,num-ees and validates the num-channels once it's safe reading from
> > > > the BAM registers. That way, you just need one boot test to ensure the
> > > > device tree description is really correct.
> > > 
> > > Thanks for the detailed explanation!
> > > 
> > > Do you think it could maybe make sense to expose a clock/power-domain
> > > from the modem/adsp rproc and feed it to the DMUX / SLIM instances when
> > > an appropriate ping arrives? This way we'd also defer probing the drivers
> > > until the device is actually accessible.
> > > 
> > 
> > Maybe, but that would result in a cyclic dependency between the DMA
> > provider and consumer. E.g.
> > 
> > 	bam_dmux_dma: dma-controller@ {
> > 		#dma-cells = <1>;
> > 		power-domains = <&bam_dmux>;
> > 	};
> > 
> > 	remoteproc@ {
> > 		/* ... */
> > 
> > 		bam_dmux: bam-dmux {
> > 			dmas = <&bam_dmux_dma 4>, <&bam_dmux_dma 5>;
> > 			dma-names = "tx", "rx";
> > 		};
> > 	};
> > 
> > fw_devlink will likely get confused by that.
> 
> Why? We have a property to break cycles: post-init-providers
> 
> That doesn't work here?
> 

Thanks, I was not aware of that property. This looks quite useful for
fixing up some of the other cyclic dependencies we have!

Nevertheless, for this specific case, I still think we should not make
such large breaking changes at this point. As I pointed out further
below in my quoted email, this is a legacy hardware block that will
likely not get any major new users in the future. We're essentially
discussing to rework several bindings and drivers just to drop a single
straightforward "num-channels = <N>" property. A property that we will
need to keep support for anyway, to support users with older DTBs. This
effort (and risk) is really better spent elsewhere.

Thanks,
Stephan

