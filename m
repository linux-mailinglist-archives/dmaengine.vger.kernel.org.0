Return-Path: <dmaengine+bounces-2716-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF1933CD1
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4A6B23410
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67A117F51E;
	Wed, 17 Jul 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BqUKyYxG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800417F4FD;
	Wed, 17 Jul 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218114; cv=none; b=IBCvFb2DFBsdEP0N3cmRPyhhZB1E8xX+PesFienpj2o7y04WwAHJKufejwd8qrtMcO8A2Q9i4BRCAbyZpGEKiZ6+TIUfHYQ/7lGAnh/hXDxVTNaOdAIFbXMneuK17xAm9xPTBDvJIlNhuPk1cAtZkNV39fYnJEP2L1PUGqqiVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218114; c=relaxed/simple;
	bh=L+bNjqM20TEcGvljI3yCANffCd+CAaBzgCmndEgrh+s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=O9YhoowdqBduP06/PGud/rxfRl3FXcwjYXsWPP1uvrJfNdD0Lz+k2KcIjh8nUZ6Lsn/1AsjZaOu3oQQ0+quWM8JsKHuSYX4u6smijEC4XYQlJXh9Fbx5CKPOcD+LqgB4OEDQiIS2Twzc9hnHUPJ28xQyzGggvx0ckB8D/W/l5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BqUKyYxG; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721218092; x=1721822892; i=markus.elfring@web.de;
	bh=L+bNjqM20TEcGvljI3yCANffCd+CAaBzgCmndEgrh+s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BqUKyYxGTrUuN5QPNcv3SXRMNe1avOvtLPbaUtMNb3Ohs8vFbzdysy4OO2RjQGjj
	 j8vrmeglSxSatGtAwy/GrS3UOIeyI+YdADbghCD+qJDWnfl9j6D7EqQ7ooaV/rlLf
	 6HytfhlH/SD4RoIWg7yYBfSx5DZWcJI+8JA1cg91Vc5zMiQQ6sWOa1q5rFdPqdYvb
	 PQhTA/CqSoNh4OJR2JGoIqkTTL8bD/HQxShrXsC2jv3pa+HDLiOsy4usvPYAnElDL
	 qXcxNgLfFdAnrxehkCmFDigMQh/uzgw74D31BB9SBj4ERlBSueRa0luU4p0FMJY3U
	 DflTRLLqJ/iPkLwxEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HFy-1sRqWy0j1c-006sxx; Wed, 17
 Jul 2024 14:08:12 +0200
Message-ID: <91765c72-f778-41c7-b131-4b99a0d9df5d@web.de>
Date: Wed, 17 Jul 2024 14:08:10 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ulf Hansson <ulf.hansson@linaro.org>, Chen Ni <nichen@iscas.ac.cn>,
 dmaengine@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <CAPDyKFrcGYocPKy-WB3EdB+Jx0=BztzXz1r=5y3JNTeXF84-7g@mail.gmail.com>
Subject: Re: dmaengine: pl330: Handle the return value of pl330_resume
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPDyKFrcGYocPKy-WB3EdB+Jx0=BztzXz1r=5y3JNTeXF84-7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6KtZ1eOac3L/UM1SALxwaYP43q4SwzU1wXSfqC5HlhdXhpLsloC
 /q3iOZH1uG/jBGKzzJwLSTIfW6IVUJTZvqKTqmd/IBCQHgs0dYBMDj/KUd7axYyt6Z4n+rO
 PHVIG7SANzvQJ44jt+cI1cjMMFQDewLqPmjB8afG7qYdTFXmZnNnsnSoKTcYvpyFjx5WNT7
 CxiMELD6dfCXEPlb7bZ1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IX4qgbXY0fg=;85ELNzV+BH/3ql3k3Ruu3gGqKX3
 Qt98wA7UyspDHZPNL3KNVhLHUjZK8MDg2JbP7/RNKT9dSf+tp2y7cQ/r0VpmHdSAAViogu9YU
 htmqMGY+H3PoEEcVGecphMiAW5dT+j/KCegoIssV/L3M8Fy8c8h28wS2RmZsKXokneNRAhGSJ
 WeSowdrUhv+dBLJFL16g7NoQe8U18R9fdRNvOryOM4ySxv1GdQpt5vmA8GuCr+LFCCUZZC9H4
 opQ8C9BLbUYgK+XZqINzi+4BV1nDX9FXbA+v+wWiM+exLEdlwJ14lqctUsnBYLuG7ATozr5ix
 W1FQIfdeqhIzGkKsD/wTs/w4kIYhbKxjBSlb31amD9o14hG6NSI/Pj3PtQnpvq4Pz9nBgVV7r
 0nn5YZyNcAw6ILFjmmhdaDe8oAoDS078iBkgxhbzy1ovuGw/ufWS+kZaJYbayX2oS03NErVVd
 1EfuO6s8NdZZoVL1k/CR0Ootttx5rwnxp8Vj14mySMbBFDtQ7TjRyt+flYLPHrwjhvgPBNaB+
 4s7cPuk7ENw8dY9BK1POT3AMxjFYZwHR/41Yg/SR/8j24jhZrCqJBG/bfJOPM1KcAT3BRwLNw
 HDxh+hAl9+vvd/3awbw7RdwxzVgpyNRqKOMdGZjzIwg9/0ORFeGWpFiogXmNzib1DQS6JdCUR
 rQw9vCKZRHNLxHmQHErhtNjGFxJUcBugUpKRdxtQoULd24PL7vyqeGwevlszx+qZjn0U1UbnD
 CvwDtQUfVQ/EsGzPJ6GtqKsJDXQLJIhTcsVMSMT+CSLB70NL47YnEH2hLIwSEeLoGZnEZC63l
 KhLg972VNwgrhohfKBB7PxyA==

> > As pm_runtime_force_resume() can return error numbers, it should be
> > better to check the return value and deal with the exception.
=E2=80=A6
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Is there a need to complete the exception handling with a clk_unprepare() =
call?

Regards,
Markus

