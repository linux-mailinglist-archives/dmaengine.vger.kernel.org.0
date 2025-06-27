Return-Path: <dmaengine+bounces-5655-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6EAEB67B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 13:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138603BF92B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72B329E0E1;
	Fri, 27 Jun 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="m65ozer2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC929CB3C
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024041; cv=none; b=GhxJJYynSifs3dP5KFXsbG06+UjTuIC50Y51YA+/ahtjaIX3phgNFdDgGyWZL/lEh7TYBocVeUjapZImeirogn699LLM2nHofkZ/lNc6tvZJyGTN+u/C9U/NB/VLfkSewmK3X1Or2B6QtajrOfankMvq1BVFM/fuCYRjjutZ1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024041; c=relaxed/simple;
	bh=nrg/5Cr/Ct/L2mrn4jAnolMDR4V2365AXYCSvZSKjPs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sKh03Q8gYFfMaC6Q+pwGqOviGkcTBvl2fpGxEmtgerTFO3Tr3eMPIqnz3hogmtr+Ehb7V39q9Kq1iVQteDPxfhHhDK0rPgafXuF22mBmTbSMYYxdaPKdrlaUoLPgT0ta1sl5fVykGf1nR4qnXreqyd1fETZn7C1zGcomgzEUNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=m65ozer2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso3809947a12.2
        for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751024038; x=1751628838; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TQIk1vNThf+KbhPSV308tydy65v8ZFP99g2fX+hJzE=;
        b=m65ozer2x2+YrV6OGSlVtJtLgt3AN5unm8zC2OlARa+S5ZKLL3S0PNEJQhU8PrsbfP
         TBMJonQayyP0LxMWECp2zT4KNGaHy3mdGnYpuVwrLeaKok4AlEoH4CtWgLr+xnJrgpZ9
         qOZEZ7pfq0WO8ZuUBwI82SphF0OGKJd+qDG02c+Wf++qW+nwDHeFYdVOWO4DAx4GW4cT
         NbAk+13orgzXztKq8gEkXb1i1o59oksbsfWDsiO0H9+kKKgLNfLoUCh1fPA/1WcMlEte
         79k4s3F5a19N+8FYmUdL3Mfvg85txlmbTMh2EjJ07PNjqOSVY5w1whI1uQUjx93Prgtu
         xJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751024038; x=1751628838;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TQIk1vNThf+KbhPSV308tydy65v8ZFP99g2fX+hJzE=;
        b=l+tFblX19MjAg6E4Kec6AUTJSppr63Qz3y4UGpfGlnKLMg8bBRjRQwf34yB0xkYj78
         MDtvT+gqIWwk0ZxOj4/t7ogwLQZs6DQoxbkeGEfc+DcYKN2GkNP5kUQch2gj5yK8sKYY
         RFIV+ZmQ/FveEzbPmWV2gVTyJFcqgereEGzjjH1U/FVALM95itghtWmBecDc4iiry93r
         ggTGPchyR2+DqNK9BIJBf7sVUpDnVAzsg7kspDd/X8rRlbbd3jDxymfWf5+2GSajHECN
         DgVw2svshDc5gTST3srD2ieKFpL3m2zK1DYbZFtYmlNNoWMI9V1GhveNkG5pEdjEgjGn
         bXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK9/HSpwqRma43Gt+evHP/3vxiZaruuRWpzistIcg3tzU2wBnOawbB68zM2VX+OjHUi8MmRcaacGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx744MT+DBuoVePeCjNYTqehAWQSjRMbhBGs87n1PhCTF4QALYE
	MnqWuTmIT/br3yYxcyWuMobUl3ayiNui2+6lwjIGYfIbEBjJZgkC3zj1ZOPp5HM+s7A=
X-Gm-Gg: ASbGncsLu/FcwK4GY6jGzWc9vGIrmlAQgCyNcGCyuetT1+oAk4qloLGEx8EQPeXucEm
	WoOis/YM+Gf7t1vMSpcxybCLIdyoaL0HahlO6Qg+ZAzXApxYvAQUE8gzx2EKAeOACixgt7K828M
	l1jmp8b7L5+4WvA9K3vRSIttCfaYvHkNnKwwVSmwREnBDaHlMIUyJoYjjvwSpEOxXfNjkO0ZGQv
	No+sI6dpFVCCpKQJkIbCB6Le8K41otVSXB+alq8zUoHZHNKqXokQfF0cxrUwVREvZWm7P91MyBx
	xG1ysyLN3k9rqUb0JjPVeiJIM87NLwPkcf+P+OMInV1tkthulLNlvTGzgecEfYjfK7HVbj+RmaN
	p6ur7mSaK3OZ/WwdbeuiNsdJAvMbC/Fw=
X-Google-Smtp-Source: AGHT+IFTB4ZISQsWRjBnTltqxZ+EzRDnHXDtrROSz2QQZgqYVC+7zZ8R4yhdcBmhaWSRI1bSl9PUhg==
X-Received: by 2002:a17:906:7951:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-ae34fddeae3mr245758066b.22.1751024037927;
        Fri, 27 Jun 2025 04:33:57 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bdafsm108070066b.143.2025.06.27.04.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 04:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 13:33:56 +0200
Message-Id: <DAXA7TKVM4GI.J6C7M3D1J1XF@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 14/14] arm64: dts: qcom: Add The Fairphone (Gen. 6)
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Will Deacon"
 <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Robert Marko"
 <robimarko@gmail.com>, "Das Srinagesh" <quic_gurus@quicinc.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <20250625-sm7635-fp6-initial-v1-14-d9cd322eac1b@fairphone.com>
 <4200b3b8-5669-4d5a-a509-d23f921b0449@oss.qualcomm.com>
In-Reply-To: <4200b3b8-5669-4d5a-a509-d23f921b0449@oss.qualcomm.com>

On Wed Jun 25, 2025 at 4:38 PM CEST, Konrad Dybcio wrote:
> On 6/25/25 11:23 AM, Luca Weiss wrote:
>> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
>> on the SM7635 SoC.
>
> [...]
>
>> +	/* Dummy panel for simple-framebuffer dimension info */
>> +	panel: panel {
>> +		compatible =3D "boe,bj631jhm-t71-d900";
>> +		width-mm =3D <65>;
>> +		height-mm =3D <146>;
>> +	};
>
> I haven't ran through all the prerequisite-xx-id, but have
> you submitted a binding for this?

Actually not, kind of forgot about this. I believe I can create a
(mostly?) complete binding for the panel, but this simple description
for only width-mm & height-mm will differ from the final one, which will
have the DSI port, pinctrl, reset-gpios and various supplies.

I think I'll just drop it from v2 and keep it locally only, to get the
simpledrm scaling right.

>
> [...]
>
>> +	reserved-memory {
>> +		/*
>> +		 * ABL is powering down display and controller if this node is
>> +		 * not named exactly "splash_region".
>> +		 */
>> +		splash_region@e3940000 {
>> +			reg =3D <0x0 0xe3940000 0x0 0x2b00000>;
>> +			no-map;
>> +		};
>> +	};
>
> :/ maybe we can convince ABL not to do it..

Yes, we talked about that. I will look into getting "splash-region" and
"splash" also into the ABL (edk2) build for the phone. Still won't
resolve that for any other brand of devices.

>
> [...]
>
>> +		vreg_l12b: ldo12 {
>> +			regulator-name =3D "vreg_l12b";
>> +			/*
>> +			 * Skip voltage voting for UFS VCC.
>> +			 */
>
> Why so?

From downstream:

		/*
		 * This is for UFS Peripheral,which supports 2 variants
		 * UFS 3.1 ,and UFS 2.2 both require different voltages.
		 * Hence preventing voltage voting as per previous targets.
		 */

I haven't (successfully) brought up UFS yet, so I haven't looked more
into that.

The storage on FP6 is UFS 3.1 though fwiw.

>
> [...]
>
>> +&gpi_dma0 {
>> +	status =3D "okay";
>> +};
>> +
>> +&gpi_dma1 {
>> +	status =3D "okay";
>> +};
>
> These can be enabled in SoC DTSI.. it's possible that the secure=20
> configuration forbids access to one, but these are generally made
> per-platform

Ack

>
> [...]
>
>> +&pm8550vs_d {
>> +	status =3D "disabled";
>> +};
>> +
>> +&pm8550vs_e {
>> +	status =3D "disabled";
>> +};
>> +
>> +&pm8550vs_g {
>> +	status =3D "disabled";
>> +};
>
> Hm... perhaps we should disable these by deafult

Do you want me to do this in this patchset, or we clean this up later at
some point? I'd prefer not adding even more dependencies to my patch
collection right now.

>
> [...]
>
>> +&pmr735b_gpios {
>> +	pm8008_reset_n_default: pm8008-reset-n-default-state {
>> +		pins =3D "gpio3";
>> +		function =3D PMIC_GPIO_FUNC_NORMAL;
>> +		bias-pull-down;
>> +	};
>> +
>> +	s1j_enable_default: s1j-enable-default-state {
>> +		pins =3D "gpio1";
>> +		function =3D PMIC_GPIO_FUNC_NORMAL;
>> +		power-source =3D <0>;
>> +		bias-disable;
>> +		output-low;
>> +	};
>
> ordering by pin ID makes more sense, here and in tlmm
>
> (and is actually written down)
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-o=
f-nodes

Ah, that's news to me. Thanks!

>
> [...]
>
>> +&pon_resin {
>> +	linux,code =3D <KEY_VOLUMEDOWN>;
>> +	status =3D "okay";
>
> \n before status consistently, please

Ack

>
> [...]
>
>> +&tlmm {
>> +	/*
>> +	 * 8-11: Fingerprint SPI
>> +	 * 13: NC
>> +	 * 63-64: WLAN UART
>> +	 */
>> +	gpio-reserved-ranges =3D <8 4>, <13 1>, <63 2>;
>
> Please match the style in x1-crd.dtsi

Ack

>
> [...]
>
>> +&usb_1 {
>> +	dr_mode =3D "otg";
>> +
>> +	/* USB 2.0 only */
>
> Because there's no usb3phy description yet, or due to hw design?

HW design. Funnily enough with clk_ignore_unused this property is not
needed, and USB(2.0) works fine then. Just when (I assume) the USB3
clock is turned off which the bootloader has enabled, USB stops working.

Regards
Luca

>
> Konrad


