Return-Path: <dmaengine+bounces-7037-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F782C1C8B0
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2315A563F4F
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209C34C9A1;
	Wed, 29 Oct 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="c+WwoiC/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60D31283D;
	Wed, 29 Oct 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759139; cv=none; b=fr9hLC1j+0SktO6roc/DJRKjA6whGnT00V4OnTbG+hmxDOTKJbxY7x0Z3GVOHxEQhHjQ7fu+hgUl+rjZ8+dZz7EPqOe6xzrJD7e4BBXYIvuTTOhAoswZxk0Oz6due6quDvigmQFN4TVNjs1i5u9fnPGV4Gtc1htgfLeDfzOardk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759139; c=relaxed/simple;
	bh=Acb2I2Pbu/oogzK66zhV/cfqmGZOdhf365tnACPEP70=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ppjP5bV9s2O7PU7ogmeqz/VR4YFPFsbRsiYRpr2v1CcOLTstrTYuqAn4ZmId5PSTC/d4AbzrGVvbI1ImaDibd9/JspRdg+A7fLCITfykhkpevYd38cl1NFgCDOgpbLmYhiczE02aU8/ldu7f8qFKvS5AVXddJYDVMjSTlYx7gQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=c+WwoiC/; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761759127; x=1762363927; i=markus.elfring@web.de;
	bh=t1w9nAB21BkiIR25+rIX4DpNqAPP3pbaX5HFUHEmtK4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c+WwoiC/V1OuEFgY9F5mj3Wv1D3h2Z/5jqWAhfpfNLOkcF6OZcfkrIg4qNNiDjhJ
	 +dJXp/ByiBqSp0QBBnlhDCDKe1Xy4JCrTJCKl2FHrt1fEvQfRbwXpWKwACi7TCqOY
	 7CSMLCIMZsSgHyUOOIeELVTgEtrnf9bxCz0PITGxnYz7tr9NEPCsaV6Zj+Q1aHjNq
	 yw8Y092uv+7gBKGfkgBRwauJDNJQUUQyjrsSIKsOsW1atwL5DXBCkmpnh/FOA6oXI
	 C+rBdGKZ2Gb9IsHZKURWDH4k4goVGk0hh5/iX1sTOpNdG7va4jQ1XpgMBS88vaVY9
	 TbSt53n30FQSYO0G+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkSC-1vqEKv1mJy-00klzo; Wed, 29
 Oct 2025 18:32:07 +0100
Message-ID: <6069f4ab-252e-4f83-8c8f-cbab4ae8cd94@web.de>
Date: Wed, 29 Oct 2025 18:32:05 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, dmaengine@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>,
 Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251029123421.91973-1-linmq006@gmail.com>
Subject: Re: [PATCH] dma: qcom: gpi: Fix memory leak in
 gpi_peripheral_config()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251029123421.91973-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9i0KtE9HrbmwcWBSDN86jgBGkdf9Q3K4aeCLNAMVoMUwXDJhTFU
 8EpjSB1y52TE1dDQZKcSWKYTX9aqfqSvzZCdgVoIKqr2222KUo6j41Yzb0hB0aJ1vZOVcIc
 +Pz69qWZ5BXG5FtKgbaqVJlyrQOhRj2ZnmFx7hsI6GXmb0kK0qnAuope50yMaeAJq/vZtpU
 OPBecA7LtAT/GTC2rpoRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w65fqY1kmcE=;lD4EDGnKVlSpuV5M0j8cSCE2bcI
 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
 foHcjfC6gpHloCzqDIHsIeIvjkJ2ZLwkPTc=

=E2=80=A6
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1605,14 +1605,16 @@ static int
>  gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *c=
onfig)
>  {
=E2=80=A6
> +	new_config =3D krealloc(gchan->config, config->peripheral_size, GFP_NO=
WAIT);
> +	if (!new_config)
>  		return -ENOMEM;
> =20
> +	gchan->config =3D new_config;
>  	memcpy(gchan->config, config->peripheral_config, config->peripheral_si=
ze);

How do you think about to apply the following source code variant?

	gchan->config =3D memcpy(new_config, config->peripheral_config, config->p=
eripheral_size);


Regards,
Markus

