Return-Path: <dmaengine+bounces-2717-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587EC933D0A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 14:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887D61C234B4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6217F519;
	Wed, 17 Jul 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oh9ArJGj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAA3F9F9;
	Wed, 17 Jul 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219693; cv=none; b=DHkqb+cfgAW58jO7Jl5Oj/gkPySLpncn58a1VouHYsQTsr+3vMlz20NgFIe870SY/22WfL02z+VLmLaQCdwRomPZTLwalhdruD7KL0GjifvtMsNH6gWuHyxCJI25lJivCmkyNc+dMEhwP9Jpos9P4LtkRcPFqpJcye8OIDh6QT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219693; c=relaxed/simple;
	bh=6cf+a6spySV2022vYe01nNeaztimlHOwHgmAE1UDdRI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=c23JTSFt1N0aqtvVPGhUZYNkBJykAo9ZblV1xwTiGmEmCNn2TAMavU21sTAJCeyg2r2Zawsbo1Gk/GbVJbpXt9oNXAdG/xW4DqPWoIusfYSHdjJn662WjjH4Ubir8QMGVYerpoFLCgnDlQi8NTw67ShGQOIn811R6CmW9hsJGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oh9ArJGj; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721219673; x=1721824473; i=markus.elfring@web.de;
	bh=SVCmOFuUSQOAus9cA5NkJ4TSivsuN6mb84weZgpV00c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oh9ArJGjByg3YgIAB+PBry+a+hwMNBdyHSUyCStTFQ+xdtTaPw38Yyw5dxW8098c
	 0rim+0qB3junf9If96E9e/IELCgboYzFVrP2JsqF1kSJ2MJCgEAUoFONbAg6qWU1b
	 oFPgrtXUmTJLZVDPGayidxplMA7FoxbeSTZ9uBG3QmF2JmZ2H+G3OFVH7WEBQ0LhI
	 UpY/HKUpDyu7LLXwOEV2YswaTGQPOJH1HQ4EMW66oQcjZ0mPikIgdJowOl6Hj4YRZ
	 DYIAKarL9QXTUZwrFjiLucD6BEcz9uusn2WJecQqsCDf0IRfh9U0QEoy4S0SMF68u
	 La51JJYtxwMvWbw/Nw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SKz-1sLQe73PF1-0103mA; Wed, 17
 Jul 2024 14:34:32 +0200
Message-ID: <ec901938-8e6f-48d1-9f37-09ba2907a870@web.de>
Date: Wed, 17 Jul 2024 14:34:31 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Ni <nichen@iscas.ac.cn>, dmaengine@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, make24@iscas.ac.cn
References: <20240717073553.1821677-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Handle the return value of
 bam_dma_resume
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240717073553.1821677-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VtwLuNOKRiJWZO0yWSItn6JaqF+37J8KZIoYnAie/Mi+b5goMcI
 HP4mvk8UICjUzO0/0OL+DJoio9MZU6/hlmEW1sZUqLRZVJ12KLnWAIRQ8JCm/VX6a09CpE6
 RRfxtPFgQC+cNmbi/DIK3qjtoHx4rrm7AQsycowVyC4ovJm7D7+1GCdjK3mqxEQB8RT8XmQ
 qwzpUkmOKnIjIfn+oGx3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qsnpxgP21PU=;vRqYB5WvQVAo0GrIRM/Ux/tZE/t
 +wM+j0C5timFLXUWBvj6NRtlHGNq+QHHeqI7aqdgyszxC3AtdIUt/ye4HZ0W5u0deNSCYwlOz
 +1fQoz1nG94YkyoS438dcxx8NrYadX3frfM3uehYJ/G+nVzpPNKHG3AGBEQRhCA7mDNa1xyK/
 v0LYkBNvNUZD10f0SyDzZo8h5hq0pWWfxTdZRF2O60H97IsBvPbJuVOW7v4SSZA2CL1A8BOJu
 SrxialEbuSYcXT6kpoLbkDXM4OgsJkwPcBULWV/KDoZTu3lC9V3lhhSj/e7Zrg/4OsTqrcmJD
 3nRKu75N5rN94ht2e+mmo7aXG/BSGUgtQmXGosBBdZ8Zhn9rxkdq6H3LSqwzJwGxvl/Mn3YlG
 aAjkCASEI3BgBehUa/2Vm7mFDSX4Ms5SeyJ7r1slY2Z/YIOpwk339bWaf97DgJvHjxGa7LGfL
 9HQu9iTznB4CnjrWaTtcv9b35fIOTMPHMyJZ18BTcGLXhBYeMNaRU519VWPgiKnqfkfkP+iD2
 5CVAl3T4P+QgT7Hg9zrng+D/HhJ4qqiod8U+oV8ZFpkUy3p7Yh5u4N3l0xi9EwV+VlUEw9Dsf
 OgNpPhqwPipc/BpZ7xUhSG6sx2QKpDaHkp15iFDGOc7/LgGQq5A2loQ27HU6/fCz0jYDcIcob
 iLBUECZGGAuGsB/Y/hCzwl8NqfHNdtkegeU64ng2KaUp8Y+Co8Dxlw35V5M3lJZwAN27etPCA
 S368uacIGRneNu6+UWOr9OD5YnZAt1lLPnnhZIj0uBpQmWZ5BscovY7bfx0bqOyeGlhq9zAkv
 wpDnlpNqhx1xrL6bPNaAO1cw==

> As pm_runtime_force_resume() can return error numbers, it should be
> better to check the return value and deal with the exception.

1. Please improve such a change description with an imperative wording.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10#n94

2. Is there a need to complete the exception handling with a clk_unprepare=
() call?

3. How do you think about to use a summary phrase like =E2=80=9CReturn val=
ue from
   a pm_runtime_force_resume() call in bam_dma_resume()=E2=80=9D?

4. Were any special source code analysis tools involved from your research=
 organisation?

Regards,
Markus

