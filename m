Return-Path: <dmaengine+bounces-4771-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ADEA6E206
	for <lists+dmaengine@lfdr.de>; Mon, 24 Mar 2025 19:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EFA3A53DA
	for <lists+dmaengine@lfdr.de>; Mon, 24 Mar 2025 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECAF2627F5;
	Mon, 24 Mar 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R5Dauses"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2E25D915;
	Mon, 24 Mar 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839068; cv=none; b=my8g9pC/O8VYxTddBuztEqADZwEJWP9tJngukgltTNTVLrMuDm9Q9JREJB9wikHYvTIutpl4485mIWlKj7QI277h16eF8kn1S6gCbwmiGhR7Xr28pOdegmYcphOvbld7nTOa+/LwSIFxpODmHI0pivhRbLJXTz99bmF3IBgETF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839068; c=relaxed/simple;
	bh=Ugip4fd8Pdklj4B/ZVd31QAyVX2ztU3G46zy5Bsha/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBrvXlT+6YRdruaz+8m/VhSlNfwhh1pCewJ/8c235IM4ZHSmbAXa9DpAkuKEehVfcDNoUc+svgB8/2JA5nbNJiIEyrGLzQrN4YqyWIZiPDVzRIrXenNw5b7IV2jo/BTFZYFGMxiJE1P0nn4HdjDAeq2n7m249eSeqDXyXk8M0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R5Dauses; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742838922; x=1743443722; i=markus.elfring@web.de;
	bh=Ugip4fd8Pdklj4B/ZVd31QAyVX2ztU3G46zy5Bsha/Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R5DausesgqbnhBZ9rriIR+mzrPsczUdHyoPkP7gCpaLxbKtU0GaeSX4nK42hF+Iz
	 QFl66AscEF8xM6xdPzSd67aIUtkySqhUedJm1Wr6eoNksFtw32Ab4Levn4iZO4Uly
	 c/s6DkWtQwnHtr98OFGFm5uBnbRnfEPn4o/J5Il3qRkitiWAApeTA+1IMMhzdNG8H
	 0D0DduJ7SYcEjx6WywjIECE+B/lJEVe7G+RI8ie+sY/cTHvKCqA510Nmy385k2QPZ
	 qzBFlcDf4TcQSEN1ccMZyVcdwd7o7gqggwtqh+ShoOzX7X5DfehWqZq2l82dYrkFC
	 H6fGBEUThwwEnhFQ8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1t2Lap0xrp-018IAt; Mon, 24
 Mar 2025 18:55:22 +0100
Message-ID: <92772f63-52c9-4979-9b60-37c8320ca009@web.de>
Date: Mon, 24 Mar 2025 18:55:20 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dma-engine: sun4i: Simplify error handling in probe()
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250324172026.370253-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SAbuJubhSHN4pH7HvyQuZsAhyfLQIhB/cY7Fku1PM7dBzzJ+znK
 KFJIy7rF7WIjRryO3MpAP0TzRJAeZLmlMou8bUAV83VJoJbg0+uOTk+MgAbaj3WwpvFH/Xu
 1ntkxxFmrGDxiek9nc4IzlE2vfQxeD8sOv0ZFEzA6AOJCD0Us5b4u8pTugFyU/PbLJ7xfMh
 cDxfSzpNuEeihAtctNcyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zndp+Xt2ZBc=;FT5IcWgiEDFexAVkd/U8C2waAjY
 NhEJydSVA4u8sdlQJ9/KtqhxElzLhdWlygPYw8a/dUe8nIOBZivJEwSLMpUR7yiNFq8rQGu+f
 L9eWKq/BItQMtDJA9vCzZPpgQap2eWhCPaaDybV9ctbrKntOKWkjgG56pu8V7oR9MpyU5Qnjx
 uQMS9m+9Y0N3e2FNhVmVlQw9UJiQkLydGQtBJ+vfUrBdx9AmmJFSvIfumv+HnrANvPIGtkV2U
 S71KzKgPxnAWJolLsJ87detQZoFkGl2FKIvcezcS4D8k8mVvUPL3fMV4B0NDryXnrJIRp3hrr
 jj6O9aE26iNOBy+VyTL3t4mFYyAtxqw69f6jLAXLWP4+lktAVv05W4S/Fl29ntdBNehfCD7Ii
 yyTbMkQw8tEyQghtf3f6rDom0OHJXFPnxkmISGgvwVWzzu7OBjKfzmbOsXKxZbyKkV6EbMK2T
 0LNKiPtwyRyL3KED0KX325rTswaQT1tMWs7y36nAOEPzdcUDvK94SfzDvja+UICKKguCo/Kl8
 JYQDMM0zaLJT13Js+pvyvUFbLUlHTzeQJTJJmZJAwCixYD2Gi3Op573en1TbmmDE0apkIC4uL
 9ag6yBxHRKnRoRNLVP6MBimbagbeJJHQISdqZHR4F4Op32kBrlZglxSTUmpI4q0JZDuEfCPCs
 xiLniaEz7magxGmf1GLYFvPH37iiy9nvUx33P5KWLlQI6W6IrpSPRLwNvEvdFGYd6aUldCQrW
 UH4r+jLM0ZbUTtESTFx+lua2x4feIfKy8E+AYovYXH3WCNZQs6Un8GXzpRevhR6H5GLNGyJSF
 ABLNBooS4EOaaE8xNJmnsNgJ8qcAh6KHwBUHhsCrKDj4fEloKzKNoDAOrULAEtyb8+NPqOKAW
 87g5sBduWTBH+/z/Sq3Tlu5SK0WTmhgLdFdP5woX5iEa6KuaGsH+JhmyABkoWYIt4pvZ5PJsu
 JcoZm32Z77NrVNJj0nXdl9stgqyBrAViASlUiivW+dffqkLpZs/oyc6N+9l6FrB0F80Qd2TPc
 nrzUARcymTL+dX++S5hBiewrSzJjbWOF8sCWz/sxhxW7823VrT9bjA7vq46rKScCdF8xLkeEy
 xZtaqnfs7Pzp7sAvijUWwNJfAy654Ee0K7DyEa28fXJztYnKvWlI/pTM5ZG1TmvFAuWCDHm6q
 f4CpqAdAuuw9TB3uW2M8iN0ise7i6qnFG8/VAo3LI4uZg41r0VNC18wirs58nH46HoPZw8yyR
 y4erIdlVSDlVvV2zHBxtT4QTellxRba9YLEL8SPXN2N4JKds8kuTNZ2NghR5ePD2uA94LJd2Q
 SzgaUmfJWX2GdDTykrjQ3y7yci/vhZVgfWPQIs9MMeNlycLkh6aqJJkvr+rdSVASk9xIPRU0Z
 hbYleqa1/YK1zKecOeECTpmiKPZ8F4baAMRVLtUAB8WUxxyLShlAgjNiFbFo8Y3Q/46/3v73g
 JFaAE+lOy0g0FOqUF5Clb/9sFBo5LADokelkYwS+t2SGOizY/

> Clean up error handling by using devm functions and dev_err_probe().
=E2=80=A6

Do any contributors care for a different patch granularity?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14#n81


Will it be clearer to mention also the function name =E2=80=9Csun4i_dma_pr=
obe=E2=80=9D
in the summary phrases?

Regards,
Markus

