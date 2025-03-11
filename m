Return-Path: <dmaengine+bounces-4707-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A4EA5D001
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 20:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0FE3B99D0
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14C25C6FF;
	Tue, 11 Mar 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="A2DFV/9e"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D423774;
	Tue, 11 Mar 2025 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722888; cv=none; b=dBo0Uw3hbUkw2IWcxUy/JTqYcbg4Whom6culLxSohyeNquvMwwZVG02RYsf25HC7ETIgHrWhAnTPNwJzsGZ/t4XzPx0jPpvRZ9gFhakrh7s+0Zi1oSkZbTuOAnR6Pkt1ZIpeOaAvUqZLDkTZKo/GVBto9ZGYAo+iRaFpuOFSYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722888; c=relaxed/simple;
	bh=mImllHOF1f5YSoTFrqJ8XmfKfvLaVzDpIxgyVykwOsU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=i6qQ27lR42BqANr3ovXiFyhFsSIQF6sTERqE7b9zGqcyRo+u7xjn2lDHd1fuG8zdvV54KJaiU3ApOhiq3f8H7945hCZYS5XrJMk8Vn0dAFSSuwez0LxkRU88uhDr419GnIXeNlr+O/XNiBoBH6qBbWUY8ZfWD5KTKqpPK8v5Dn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=A2DFV/9e; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741722855; x=1742327655; i=markus.elfring@web.de;
	bh=mImllHOF1f5YSoTFrqJ8XmfKfvLaVzDpIxgyVykwOsU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A2DFV/9eELx+E0MLju+gvBYPlDj2tB5qXPjBJ6Ic6LfuNwDgiKPwYDxQVZ4BTFCK
	 Nbu+On6yMvpQNLHbTVXJ34Wv0ZeBMbF3syfeLjriWGq2JYLkSyYkwTq1EsK5yzwZr
	 NyhXW+d+KFmcuCrrhtXpO/vJLeKwe0v3kXBqTqUMGyautyDmFTnf5XA22wfUqP6Xr
	 Wy5XODwBippDAfPpbL+3CyXiUiLF4u+i0tGZcW+gdeQLlxRxyokyBVlwMerdaVz14
	 xNPcTvIcP/lZMFT3OTE+BEYIlL5EJCZHbI4baQ4QRqutFGF6T16hqDslFuf9poN6g
	 DcxyIk8y65yNLl16hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.40]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1ty9gH2WaE-0076Ut; Tue, 11
 Mar 2025 20:54:15 +0100
Message-ID: <885ceb3e-d6c6-4e7b-a3b6-585d2d110ccf@web.de>
Date: Tue, 11 Mar 2025 20:54:13 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250311180254.149484-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH v4] dma-engine: sun4i: Use devm functions in probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250311180254.149484-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:csxRDaKr6HL5KWEyrXTAxwCUqgGdHfeEmtfVOjb+dUzcX32YGAJ
 LKwKJCqKYMVT0xpMnBQyeBtJH8ETx4v/Klf0cqiH0J6qM3JxwfQ/b2FiT3gFHkld8w1EXb2
 fgnoFkK2KwhXhyhJ+pibeC/YghDSJd/YeSJ5xc/vaEtIYbyimsNUZoLcbKAfWq56Lrg+/YV
 N9pktnJXiqt6ibo9A6ZgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yvb23s+8boU=;2XsQvEXf6tSU1WJIIuRcp4Jjv7G
 /GHJKSr2DTDPZI8J/i076i1oTK8Jkl6em4FEUxyRpVfYcdScEVrZn+kF0OcJloLCSvm/4E5Ie
 W+/hVY0H2NVClF1upl5sc66W+gh5QfD2C89grTSWSBQN/eAif/Cs7gS+rlm2Hie71wXj9UtJX
 BY3ukIW4/aO2HrWEpI8hzVOAGmaHHtVQJYX3Dewk9CLfA8DKH1QiFldjbu0LvLlWq0EHHY6Gg
 E2lP8MkCKmzNYjnomqdTfEp/+vlgsIM0qYnaP01L2PrXpmQNmz/YFdhBFDefgakj34XBfPd/d
 7qFAKt03JV8WVyC4JmNtkc9Yhd2wwXffUiKfYG7Ik2x9UQ6az73ZK/4SPhXA4STYMqsK0mC2k
 krDx20xionaK7CXWYB5P2odri7/BQcR09PzjkOIq1BYORAlUbpsoe8CsV1E4gOBY+YxhiRyvI
 g2N6nrrIM7Pj4wxr0qLIUWs9wohrqiAyb81LPP8MF8ekHIAFwcwQGGVPuEWVbypke1H9pG4H+
 k0SomtBxs8gepSlMgksTRhT0acbgSnaqCqjkAYeR6fwIUQZ9rumGWFcFTQHHUZ7GQ07XDDEjk
 t00S4437IghEiUMT9pmJNQBKhxpULgJ+RVxjlhuGvsCdZS0vi0UuQx5Ll39VUnIr2//0cRQvd
 Ork/M4MnjaFVrRrrQqKRk+IfkRIKbREMQvQ2p7QqCl0Zr4JghWMCyWFcsrMIH9tffW11e0IDU
 ApCOXAaJAcy3YU+GM7Rm6OwxZFWEMgjWDj8WqfB7yBQQbZGtKFJVuRNc621l1Nenocy+3KVru
 gdWw+3wu3DETzFk30wheJpqbWUET83N6NpyVBUrBGRaS8IelUvdBu//dCm4rXgp9TAJxN1FSM
 /Q51ms4jbEwKfwBAEqXuWc3DYhtF6ULUvL5+tneinAJO7Uwb0yo8dtCeD6UHD1e1XPzY2hiVt
 jfL9NhcN0S31QO8XDLVSa6QRwr0s1n3W6yFwNkhy1Ud+J7+1OhuJ/jsIg5G8zDawPLV759SC/
 llwKk2ScsflOtuAuldBNvQdMn9UQZNxOZ3FNXNpswMZC92Zf1Coe3pdm0p23v/PaMFdxaszZ9
 JsNa8uL3iZPL6jhNrUTw3uEXa9lX2kb27PNmRwvE69BkjnsGd5p+rLw0iHb1ywvJIcwj1ARlu
 neRGNhcFUBSn74DuudTlVTxECDZC7YDM3bWKun9z2EXECkMVQRMJKxKFSE42C4CfLfjLYaMlf
 o6WIM1ZTaXLQt+xe9gNg11fuNc4h4ZiJKJV4t4DefC3RkmBbjX8jDHcYVeBhw/FI/Z4FR4XEI
 zbRWrqKmjAi2LLsvdIKWWwh+SjP/ScIJupPVCwFMxDGYzsYXcfPM9SSZbLTlOr91eu49wELuF
 mmynfkvgDl0KFk/1LkC9CVQFaj8oOKd4UEnf2BmlvR6eBUFreLx60OKm8/Z3B1y/xkuTl6S19
 VAONiXg==

> Clean up error handling by using devm functions
> and dev_err_probe(). =E2=80=A6

How good does such a change combination fit to the patch requirement
according to separation of concerns?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc6#n81

Regards,
Markus

