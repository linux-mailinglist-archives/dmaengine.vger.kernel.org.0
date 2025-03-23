Return-Path: <dmaengine+bounces-4768-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7081DA6CE54
	for <lists+dmaengine@lfdr.de>; Sun, 23 Mar 2025 09:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F1E188EDD8
	for <lists+dmaengine@lfdr.de>; Sun, 23 Mar 2025 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1D17BEB6;
	Sun, 23 Mar 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VIMimFAi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685C3FD1;
	Sun, 23 Mar 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742718676; cv=none; b=FcGziBtzbsWD7Dy0FzIMu5YBkmH5/fa/AzOR/M10v48LS30s4Hw4kq2ORpm6JQctXlYLngRgKDLrZzEunCrx8LxyQCSApbzF0iqyhXxoS9Tdczo7n1AaU3b3fEw42Kt8P6U8NnXB6dot3Rm44Yz23w5L2t+crEBFm9J/ho3STk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742718676; c=relaxed/simple;
	bh=DYPNU7IrXM3BAA5bDt9np5+DeRI7TeRzLYJArUf3A84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCf5XvqtnxmgmdSj3GBjfSHFkFagX12LPPXU8UdQx2x9qweN5k7ZYwGPy9sNmJoYOsSVP7K7UmM/PK9ePNkJeqSI+slSfPelCMWc/BuEMaaIvgBlYoKUBsSHFnb1YeXVMGg+Nw39JR/15vtMqptNNNharj/aTUDZQ3IasxgfI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VIMimFAi; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742718653; x=1743323453; i=markus.elfring@web.de;
	bh=DYPNU7IrXM3BAA5bDt9np5+DeRI7TeRzLYJArUf3A84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VIMimFAiNYiWnto0HLD9gvyhH9Teq0oGbpaxVZz2KUd3uAZJ+3dRIb8lZhbyXlSo
	 XbVlSPYaQ46JkHNu55JWfsn9x7p54idTHIHGT3C+uQyYDSXjUDpBuGoLETTq4HSRK
	 3Nx5U0VOAkqJAcCXZcgF2K3TcFnlBj4q8S4k0dKU5zpKnsLiLN+oDxSHQ78gKwbYe
	 jSLDikgNjpOKSL1lH8lY/VrCFdZL4HNKFv+4fHCyzxIjVF/Q558C7Wc0qk+KivlRP
	 66DCXJMxBBHvXJ8kXjbJdQpLjUsBJm4SRcY2jQQz7Ik6abcn8mbGSEuObXrneagh1
	 zrti/qqb1UWxxq4Gug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.71]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwjc-1tY1m12DLU-00MYlX; Sun, 23
 Mar 2025 09:30:53 +0100
Message-ID: <352b3fb3-0acd-44bf-8f69-cf72b5d27e67@web.de>
Date: Sun, 23 Mar 2025 09:30:21 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dma-engine: sun4i: Use devm functions in probe()
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Samuel Holland <samuel@sholland.org>
References: <20250322193640.246382-2-csokas.bence@prolan.hu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250322193640.246382-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eok7N/ZFTQPH/RQ/eVBr6b5jC0i/dy6yeFBhBmj57IReVHa0aDa
 qbRh06yLzMUPZpKRncmU9SPEssGx7qTPaLN58ZKELTkKtXRah2HhmLxfGLqRP8kASsuZjqE
 YX6u3nQqKtsYrc3G8wAAD8/NVbBcmZxvwqbTdW848BaJ3Cd5ITThEsNw7/+fVitGEU5Pjaj
 LMubty8hVyW9lL23kL2HQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dAswLujEvUw=;9KVLCGNHyqed/0kFl03BZHn51pP
 JtULO5FjGC71GnLRkuJmDwVcaad3GtJ4sWROV/cHrnK7YVqurRfU2JOMy4wa/qMTUiClKb+XM
 i5dDhKLnihGijJ8rcUtOCqsj4L7Hwd5gV3kfI8Tn2tYl1RxH7YIXUdaw2uWR5Rh/fnzEJEXvK
 F81r6T3K2M38M0s5r+kag2r5+y/blWAzlfaGLM2KZMQbrYIWz7GZDwld0VRqnkQEdzMUtjSJc
 SYpb3O+zoLnvBHzS/HZWb2ly80REu8e4+YDIrGz/VwGpGNyOwEsjWAE5qRx5Dy77TWUKVoJlc
 ULI6XFoiu2Wlj6qaLUIZw1Chh2u2m3Eh7rI+xUWqV5h75M9omCyks454bw7E1o6iqkJi9BXIL
 K//cFsuR/OR3NodNia2/feiIq4anuYEJCgjkaHvoyUb15KcMAzADYR9giYsbVfpOF4MSHPtPr
 /CayK9cXHUdjrE1yiCmB/EeMp8u7IAv7vmGQKi2z5w1RXAM/PndOBUJ1bjjm6c0GOGfNZnM8I
 dlZm5SVpF+TTZPiRlHURFekB7dPJwckgUvVsyoSGMCR2+5lCU+zg5h3akxB7l0gJgYrap0qT3
 rA078/SRxVSZ4+TKQo9JfxQKeFdGvhQlrg4L/dXG+YiSHJHuQA87/Q7BNyBKaAL7P/L/hNueB
 YeIPyne+LcjWdgwbjyoPKnxf0R87h9zjXcXAEHxahhOvQHe6dbtqVFmGH38Yslsr7ZjyOhDnH
 AmTvOWHy/U52vph3+/wvBHKr8IDkji5u2MF0RLMXfoy36/roocdliXxwWWKJ/3kz5X73wsQ7U
 w/DBxqw0BeEQcARYeFvZZ3us2Kfuxf7JUd5OUu/omDgTmMnN8rCmZqhSlstBa320ibbW71OWg
 iQJ0sdevcI8hxxwhhvXLUpP+XgpW4EjE+8olxJt4KPMmDI3pKMWh7XiqhiY/Vga/9Z4sB68zo
 H4f1LWoKLEokg5BUrImjEa5hXR7V9kaMQOTKvBLYJQjGmFOjC9pe1QKz8QMNX+epWUGjYZg2j
 R4LBji5Q9iu56kK7eU4znvoqYJO3gl80PC2EGY9KNbK3F0gMtg0a/V6960lHC2zizRC0YRN7d
 NL7JRaJFD6NRpOQUfibofYIZ2U3Q9+feRQ+7Z07DZFNlKfS7y3b3g7cOmQfLfPyKDDlJ9y2MU
 Tt1clxt3Vzf5C0ifJuZ15d+ai5xc7EKUMK6yEsPDL0wKGQQBEb20E5E3LBzSZqaEghN0tNwO6
 T60z+pO9Dg/tzBBm09OGl4SoBDDn71XfRC/RVj8Aj0Mc9EwkkCmMy6895zcUs/HxHh6hV5uQ6
 Y7eOwdpEsK1uEuvicb+i9S5vyUyEVHftT8+KII2Z2tOB0cKfnUqGFPufTkNCG4qR2VpxtzemQ
 nX/ennEcACKse+LcnHz3F0gozgCj3XZS62TNtHsvZfacf88YpEwxp/bnSL/G+QLmxI4hPIORc
 6/5rd2dDXQkXKBU3k+zvybNZ7oFsjE8VZl57nu2g7H+SOomBx5Ye4ZOTdMH6I8aE/nD+u6Q==

> Clean up =E2=80=A6 and dev_err_probe(). =E2=80=A6
I find it more reasonable to offer such a change in a separate update step=
.
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc7#n81


Will it be clearer to mention also the function name =E2=80=9Csun4i_dma_pr=
obe=E2=80=9D
in the summary phrases?

Regards,
Markus

