Return-Path: <dmaengine+bounces-11126-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a449OigHH2qtdgAAu9opvQ
	(envelope-from <dmaengine+bounces-11126-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 18:39:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C5630462
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 18:39:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b=Dhp1RuoM;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11126-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11126-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linaro.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA4733006124
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2026 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6D371048;
	Tue,  2 Jun 2026 16:38:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5936F917
	for <dmaengine@vger.kernel.org>; Tue,  2 Jun 2026 16:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418320; cv=none; b=quXvJ/hnRPkUuINpB3yDLKUVoAUK4FI+gPUVWSsYThdynjCent6IFp6vkaVa4AQJN6WSeg3606viA109bFaUuW5RLW1V6Mq+UCplnHU/rJ91x1B+BA2BmJCm+ahOd2iX7w0GT/ZcVIet2rIgq6bX7dSCur8DUNv63YHKbbSECPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418320; c=relaxed/simple;
	bh=SqqoX5qQzGE5eNHSgLyrNrWlqXnwPa/uOKYx/N6zAZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deeaQWooMoyifU6zYFnBoaZgTuxuBbk9quFSXuyRJPJrbxCnzvYOkjUgOMhh9bAtU0GNERsC1iseBjqaxUqjVM8E5VqiHUi6Eh9dvgSaLRYzfau75oG05RZRL0SbtDG7+OYWjFjvXosjS76uLO3N8MyGZnX+C+OxR4P28ptWXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dhp1RuoM; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b12270b3so7674135e9.1
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780418318; x=1781023118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqqoX5qQzGE5eNHSgLyrNrWlqXnwPa/uOKYx/N6zAZQ=;
        b=Dhp1RuoMIgkOz1tIgivCGlzcEfCM/F0TwNwrOlD30SOrPUP9X0pk1jKf45MVZXD2qB
         Y0U2Vh/tibUVKER8x1Wo8FLqPs+VhIPGR222R58rC2yCrEfGdyQvYBOE+pEfchOdbhkt
         pU0giNtPmGEguen+ViRMghJUGwIMgKi17GuJksCNJtyfUNChDz/NmidxQjstu3eUEQOs
         xrFrShXa3Na1mri/KdchGz82zqQrrsxTxWshTVVGcANc39kYo8SSegNQ/J3H84x6x7S4
         aphwriiQvgNf31lUKqNreRJvIPavKKUfsDPrxRkdD/3WnNff4c7FXxWQCPyX6HXerUQT
         PGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418318; x=1781023118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqqoX5qQzGE5eNHSgLyrNrWlqXnwPa/uOKYx/N6zAZQ=;
        b=JrsR68qsINsvXDUiCRuSY5S16R/irAGyRC9nng4KH2WSwj9enhyjKX5t22HcPZgHPE
         4RuVKGJKI/XZPxZ3YVGagJFleHmBZPgtERqCJRGV/BVXz3Ky2EXhBTbkX9X3O4Somi6s
         3Zt6Fe290jwoAGcBgki2kZUsrLhVRdTpQT9L/eJrVhp+NG201ll3XTRlDjzUYnI9wCP8
         Hdu5e1zoZEbPnsQvxwI6zIgd7hHYB89Vwm7936MSewwpx4ycOXydrNc0q42eYENaj+nf
         YZf9VXkmZD96lhLis8VOIHNqcit5vb5+mv5Kqhl/XTIsvvWIW/+HAeFF2m+lD95vUZJ5
         eBWw==
X-Forwarded-Encrypted: i=1; AFNElJ/XjjCHcA5mGss2F/cT4D3ktF1kxc33/9V6k8tfu6zVf1YcuAXMm2MMNmucDIAATTqxNZZjFIXTdgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXIFNeXfG68AuWNolnUkoot1WCtlLtEbTkk/5K2HfhtQq9ELs
	wASGM7d6tLu4vKki01noNnfGRcrQX2Ne9N46m0hwFC/Xi2v8e9BZAX7IstixuLL6Fts6rM6WTnm
	RZw526yE=
X-Gm-Gg: Acq92OET/YMmn5UFuGLGQG2etl9TsOPSfcjK19OlzdSSayYD0t3KWncDolHVniMw4R4
	dSFZtt9YEZgKHc4CvUi5UYU3P1Hd8nA4GXZlsp6Sr8dTwuvQhW1r2q6nhEre6BQk6WHYVbvEvkh
	VukPegKq1eE83B0YaimYlDyWG3Bmn8pcfSBRUy5u+5aLnP5lhVZxMgr0lVmOkfI6hdECC5dhdCv
	HPaFPZykmLfcDUDjiivgu3KmSlGOE7qaIyIV+gXIkViabm1vDOuMcgL5gApgn+ScPVZ2gZ19LIm
	TxZIljwgnoO9ZYXkgj4I1UMz2sdV59qaCd2r1W5YAbEEwBSDqxoUBIkY83VGFjJt4aVRGYpW51W
	svEWRJzGDGY8Lpmrhe/whoiMIdgUAjJiO50qDefZrAx32nex1FGqtWqFdc3kcqTzyfy7FcVmd13
	9bwjb1H5LunAL0yXuQqDXbEmncNwAFmVV2fsDqaY7sthjw1w==
X-Received: by 2002:a05:600c:608e:b0:48f:d1c0:5cd3 with SMTP id 5b1f17b1804b1-490b5065ee5mr8757815e9.13.1780418317804;
        Tue, 02 Jun 2026 09:38:37 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff23:4410:9db1:6daa:c0a7:d3cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm407269f8f.10.2026.06.02.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:38:37 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:38:21 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	brgl@kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v19 00/14] crypto/dmaengine: qce: introduce BAM locking
 and use DMA for register I/O
Message-ID: <ah8G_ajPS1KhgPP_@linaro.org>
References: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,codeaurora.org,linaro.org,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-11126-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[stephan.gerhold@linaro.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephan.gerhold@linaro.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:mid,linaro.org:from_mime,linaro.org:dkim,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 865C5630462

On Tue, May 26, 2026 at 03:10:48PM +0200, Bartosz Golaszewski wrote:
> I feel like I fell into the trap of trying to address pre-existing
> issues reported by sashiko and in the process provoking more reports so
> let this be the last iteration where I do this. Vinod can we get this
> queued for v7.2 now and iron out any previously existing problems in
> tree?

Thanks a lot for working on fixing all these issues!

I agree there is no point addressing all the "pre-existing issues"
pointed out by Sashiko, but have you looked through the other comments
for new issues pointed out for your patches?

Out of curiosity, I was looking a bit at the comments for [PATCH v19
06/14] dmaengine: qcom: bam_dma: add support for BAM locking [1]. There
are 8 open comments there (Critical: 1, High: 6 and Medium: 1). From a
quick look I would say most of these could be valid. The critical one
about the usage of dma_cookie_assign() sounds a bit concerning to me, if
it is true we would be basically breaking parts of the dmaengine API for
consumers by inserting the lock descriptor in front of everything else.

[1]: https://sashiko.dev/#/patchset/20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a%40oss.qualcomm.com?part=6

Thanks,
Stephan

