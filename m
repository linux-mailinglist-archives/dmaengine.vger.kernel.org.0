Return-Path: <dmaengine+bounces-4778-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD61A7012D
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 14:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAB417B1D2
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF526FA40;
	Tue, 25 Mar 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="f256tSmp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1026F47B;
	Tue, 25 Mar 2025 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906389; cv=none; b=g4PSLyYVSye8Lzeeg7w8xtoKsw339HLeWuP07yMvejVeuzw3BQVs1MKaPmjBsMI4EWKd6uVfIhvdwTdgOXoOgFDZdOAryvieWdREYJBQmAsgmNgK3M8YukYQFC7e/YxPyLhIVXBWCpyIjHRgdlhyJkeWbwsMSGP87gbKL9z6tKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906389; c=relaxed/simple;
	bh=EJvaTHvV9TkEAhE0kh7p5puwgCBBIeP27IE9sliGY+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCdH0VXBG8feKi+XhD11Gl90TLED6db8RZRqR9SWmNeoNLi+WiAeCnCZfdz0AgAZaxkvy/v27/6DT+qrvoC2IKo8OxcJ3qDIwUPxIislxVh4i0a5k3Ea9/wwo8rlXE4uMcRUUyCRgdGUjly3q4yIweI8fkmbluxGMnog0Yigp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=f256tSmp; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742906347; x=1743511147; i=markus.elfring@web.de;
	bh=EJvaTHvV9TkEAhE0kh7p5puwgCBBIeP27IE9sliGY+w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f256tSmpfUX0j5+Q4cozF60Gl9YvBzgvGaByJlOH3aMJ3c8Q+NhBHy45n7VipXli
	 KARsEXc5TlDbfVE2+9DYAVMjud8Dgl+fOLcfQlIB8r+rvh1AWwARgfkLNqoJTPpxM
	 4Fbg2zDF2uPqsAj0xtPKbPiF+h080QIbzJwiSUfnxiQHRaiqK3yLoh9ymSmv4NoWP
	 l/tXs53QDL6NwNPV2Z34Qom71FwyrqhlLoG8zCHhCflCEO9h9bqGHlSnykFxbK4tU
	 nAGcv2o9hwzproO96TJ0ydTeZSud1FqHU6zKWDNWQlEpfrHBjOaqWdcOGHp7fXtaC
	 9qw94onFeFOGQBTQXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1u1kOQ3G3l-000Fue; Tue, 25
 Mar 2025 13:39:07 +0100
Message-ID: <77fbff4c-443d-4ed4-8335-a6cbec6b2809@web.de>
Date: Tue, 25 Mar 2025 13:38:57 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6] dma-engine: sun4i: Simplify error handling in probe()
To: Julian Calaby <julian.calaby@gmail.com>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
 <92772f63-52c9-4979-9b60-37c8320ca009@web.de>
 <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
 <7332ccd2-ebe6-4b9d-a2ae-8f33641e7bd4@web.de>
 <7afcbbee-6261-4b2f-be14-a3076746d53c@prolan.hu>
 <26e36378-d393-4fe1-938a-be8c3db94ede@web.de>
 <CAGRGNgU7t85oG3Bq7L3KjKUAbRyd6SHSM6F6BvmdXDVkbNegKg@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAGRGNgU7t85oG3Bq7L3KjKUAbRyd6SHSM6F6BvmdXDVkbNegKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9CyG8ypY5QKj6AhZu4bBlBd7xaoOmtjIcy4YmaBDsj3YqIyZhKk
 PUktB1EqYYQoHv12uD6eMe7ewOJNfdqf+a43VZcmuf+xW/B+cqjHZF1YIuddtDDM82Srbmm
 sKIaJ96U4yyml9L4xAgB/lVLUCUzDmOWhol9hSdfEJ7COscAtAsD5d/SRH8GkLAhoUcQhpn
 GcfVX89seWKeYyfg/CSlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2idS/XK9DaY=;OR4JaWiRAi3GuG73tU1MlMDztEJ
 2omG9oC5KLryibGuBsLaDCnazAklLQZI6ijbJnjl1gTWn866z4XRMeq4Dy/Wrz5phvgVXsfZD
 pE2F4KZfhFvBkgtlZRU6SmXulu8bVNoa9AUx5vOxGPgEC6l8O7bud6oVScp75NUUDHaiLaZuk
 FMrttwhLGvUuoCNcIwO6FHbpQ9YX/ngBhBRXWycGwKjnpIQDiYKwtD76dp8niiwogeDKy+lHY
 eCzm/k8MG1RwZcn7twSGSCuny1I4dLb/ILowaX3xHHjq4VLKH4+2BC4lP+MVUsQVnH+YrR6Da
 AIo0rcerYZCGQqSU9QGkp6vOba+Cvqg0NR6ITIB0UXqHShjnYeUKPSHE4yvraouAGQI/7wM26
 b5wW49+aBrZ19Cwoi/YOV31HcWIKKpuv651hrFMR1GW3/cgrj9zDlmwReHodHfGerN5MlGCG/
 gCaj5eYlNU5vF+h/8h8d2UpN2PoOfKIzrBiNi3udY4WYruQcFnbjhz+KK943mRVTWGegorU0x
 R7C3gfH2W8jO9s9flcg545AeighTffx4a62AM/B+VW52uU6f+BECy+0LHw/s4bcGKQ3xgZMGe
 KsEpSN6+RBW7QBY1xyWVox2pA8NjlD/rgeZD/MohrjgbzGM23Zt0sKh+ubYXQ6sj7EEl0S+iz
 Ile0M+h76ViE43tPGnezxl1kO5m8C35aCdSPrRAt1Nr9pMHtB6zgICPlX5lCjUpouh9Q1kX4f
 /7Trl4ErBxvVb0N50ABdY/8ltifwMOveO6aci9Yfap2/7nAC6Lv78U78HoqfCseOYIFf0sLse
 +5ekVJ3Nki37L+8ZhOA2v3pfDrl77UdxQxRutFOS/kjRbsnPvJ89iidwziJ72NAUauDFdLYgj
 WGly08yr0Gg4DzGHXsVa/Zy9SwrRG5PrkCadBso65Bx1SN0RB5PlCHiSTLww1tm98BrEu6jSD
 4uHZqC+XeRej0/673H4nZJfuDVxI8oy9TNKFz6eHmwm14vJDGdebaUAcy2xCfwmULk9vnppFa
 fh+10orUntjsg1yCZ0UnngAEX7ZDZPJfvGb2xFM7/o8+wM39TgBKbIqLjtCbRvCzLBu8+dcon
 ajsopM9cSZv0eMqsHId8B5Yze+SucoZ78k4Ond2Z6c4ySsxjYE0inVHiMJ6gVvLyEJprq5Mn4
 9unOwHFZC9/Wt4inxSucuJJF5oH/aYpf/cOahaaMZxF/T01nOEGlpbsXoEx8/2/l1YpFXbbv7
 6JYlomrvAemfNl5N1T5TFNRJIGDKp7HqCOtkGzReWaHSA/HLnGcAnucr7rApzjk82lcHbZyCy
 s3Y5sPcgXiDl7gWy2mAnJOojKmNrj/dPSrsW8atXGkCPLS7aLvpPNRhQL365+yzHWYlFSsEg3
 4GTXstWJH7zilkrzHP+YDiLGPAGtBVsnRTKx02V20bLckLydpKZiLxPBcyCL42bjgdBGUR4CS
 fjsBM1lHbil8rlsvbI3D77qh6n4znPzR2GuSM4pHddlZZwOY9

> You're "concerned" about patch granularity, but this is not the sort
> of thing that some random person would raise, this is the sort of
> thing a maintainer asks for when patches are doing too many things or
> are unreviewable. =E2=80=A6

May additional patch reviewers influence the software evolution another bi=
t?


=E2=80=A6
>>> What do you mean? =E2=80=A6
=E2=80=A6
> Once again your comments are just noise, and your insistence on
> repeating them over and over and over and over and over again is
> borderline harassment.

Some information needs to be repeated also according to known communicatio=
n difficulties.
Corresponding views might be evolving further.


=E2=80=A6
> Please block or ignore Markus, at best he's a nuisance and at worst a tr=
oll.
I hope that development discussions can become more constructive again.

Regards,
Markus

