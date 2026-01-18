Return-Path: <dmaengine+bounces-8323-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54112D394A4
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jan 2026 13:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AE30300EE6D
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jan 2026 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588102F4A15;
	Sun, 18 Jan 2026 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cTJURAmD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711F241663;
	Sun, 18 Jan 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768737689; cv=none; b=dVOwPDRKFIVRAxzu8j8LRMUH8ntongr3vInAUXXtEU6sqpTVF04syzdoYTkiTpA2s6X27i2tqPwjUO3JM9P4YmoWGu53+oHWBktYmWH9oI7vTKBvOkANNMpjCCyWWHH73eKhUQUY+8nEZ+Z/3+fXljW6iTEGVfQdWbnZ445ZRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768737689; c=relaxed/simple;
	bh=wnB+uBwOjBGFlGsWs9fIGAbWdtqLerHxQ6Q3N/KcRFI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=o+Q8Ded90z12OhRn0UxRKJYZ1Xo1xQ5zh80NweQPIBcK0NBx8ES9QtqMpteZ9ZM6HsCb14Eb41h6Zf+j9fMItYM4mGnooDZFmB+H83jyvTu0aeX+79p2ajIZEz2ugSnzfavm0IGxcIrU1B7lLCdg8Ml/3MbRdMDAhzAR2GouLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cTJURAmD; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768737664; x=1769342464; i=markus.elfring@web.de;
	bh=0jdkaNY+/IRIq6f+DMBcA6hUDN8D2qN7jOeCgydmI0I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cTJURAmDZK6Z+0eo09Pvg8v/yx6M4zffHUPb1ATLmoQsweo4Bffj9qzW9CZoiYNV
	 UpmrzM698F/pixarvIq8RYl8z7oPqomKDoxWqskfUVE6YNxPFH3vSJQTUMNT/KoPa
	 IVa7/qmnaQWhIwhtsakqZNzwfRNydjq5xrACAIvWNA9k8ESBz3CyGB998YxuCa6rQ
	 91Huu/ZTPMNDYORpJFMiJbYQMKV1OJHMNIuM5ZgZIKEyNl8M7b7KxCZAjY9P52cZ2
	 5H6UVfUCRLz2RRTsSf1sFmwAgcjzfdEOZTf5nXeRwqm55fVPacMe24KMT06+Qly4n
	 +/MkUDheQJTn+12Bhw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qv3-1w2QhJ1n8f-00u3xD; Sun, 18
 Jan 2026 13:01:04 +0100
Message-ID: <294276a3-a633-48c1-86cc-4c15ce43d96c@web.de>
Date: Sun, 18 Jan 2026 13:00:15 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260117233930.9665-1-karom.9560@gmail.com>
Subject: Re: [PATCH v2] dmaengine: dw-axi-dmac: fix alignment, blank line and
 non-useful return warning
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260117233930.9665-1-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tin5mmwglPesBaioI3G+uYNdaJJqZ8zRdIqibRHb+l4vR/FZpos
 NRBgZZYakRuSig6bB4PpDqGMzru+LvEQ89eTuZO7UlK43+wnAJLVJiNLjIkcrPaX4iXee7X
 g5XOnrqwXjpHOjh1BBhEV3ly5iIf8WLjf9T2qzPRDynP8Bjr/xAerU57WK40N3/qfBo1qW7
 FHwVEF4RpBWtiKe85PUlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rah2NHWCr5o=;kEuUGIv7yyd0kT4Pxx27WQ7Mg9z
 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
 QqzPmcgw=

> Fix the scripts/checkpatch.pl warning in
=E2=80=A6
> ---
> Changes in v2:
=E2=80=A6
> 	- refactor the commit title
=E2=80=A6

I would prefer a stricter separation of proposed adjustments.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n81

Would another small patch series be a bit safer here?

Regards,
Markus

