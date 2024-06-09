Return-Path: <dmaengine+bounces-2326-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC090168F
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C591C2080C
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD5481B8;
	Sun,  9 Jun 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QT+uXqe2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2147796;
	Sun,  9 Jun 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948234; cv=none; b=NVdUIVvNSiEIIvk/N1eBG6nwDtV+gOz48dN+Lz9jTQVBoRsEshW5gz6YeY+uwlU+ug1Z8eCxBKC4xuuKo/3i8FKRwngABZ1mgtbsazjOPf8q7kmQPhnFLpJEnH9OrNEm3+AEgzmGBTuufGDlvZgbSnJUiSuF11uroYnSby6JJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948234; c=relaxed/simple;
	bh=00hBOYAX+ECbeAdBZy5k4ZIDHwz2fGhyfX8O954VvDk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MDhl3vXSeEYQCYJk5AGan7/jXi7rhT5tg5ruV4/gSpz3QGLGbS5AsgcCwUPag+YO2Gh1kmh7mjkDd+NHZiiZc98ubU3MpLnT1pGZgOso/e8P537wyUrdutIGJYmgBNHLSz9oJj8r4BKTDdcSRTRD0WBHIlE56iXXjpva+CAWa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QT+uXqe2; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717948221; x=1718553021; i=markus.elfring@web.de;
	bh=00hBOYAX+ECbeAdBZy5k4ZIDHwz2fGhyfX8O954VvDk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QT+uXqe2cAP8JMsSwN+/EiMyV46T5I3LmlsQC4dovfBv13l/k+wGK0aNe36szcHu
	 s+4fO03aaG05/noRttPQx758acxP4U2XHZITfAdeNVQd91EHEh2PubRW/EIXd0T71
	 rUl4sqtjKZ4X1FcVI9uj7qqp6MWnJNLLp3JciwjElKsfNN14xk5W/OfWP2Oc43cWl
	 XHja/9y536wKMbp3abKkAZtYxrzeWfM2HUL/JGJsFcYNwOXAgD/NbV6kKpl81zfWG
	 vOhOxWLbcjcj0TMKo6aJ6LDr8NpIHS9fRX2zg8ac45ZVxVa45jsj/FrbkPi8jfo6V
	 xpykBkVmN9to7MwGyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvsq5-1sWtac0b4x-018Di6; Sun, 09
 Jun 2024 17:50:21 +0200
Message-ID: <4e68aa3b-5ada-45da-98b4-4d79d959b48a@web.de>
Date: Sun, 9 Jun 2024 17:50:17 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
 dmaengine@vger.kernel.org, Stefan Roese <sr@denx.de>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eric Schwarz <eas@sw-optimization.com>
References: <20240608213216.25087-1-olivierdautricourt@gmail.com>
Subject: Re: [PATCH v2 1/3] dmaengine: altera-msgdma: use irq variant of
 spin_lock/unlock while invoking callbacks
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240608213216.25087-1-olivierdautricourt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rVO8U2r4Eg9mhNW7fg6fA+4iQTndCwc9PmXVfnzaIMMRqJhADG6
 ITnbTNTMEffEBJ94jyFJCXipFlF/c8yRMpeSVnGn3SPSG0xTrE8ZBu0AAmG3WNy+IaPcKiC
 YNwO2O0jmZppQXgWzccBPPJPtXKkdm99Jw+tf5B7YgF5qLgJkHInnBJUYwEeVB5VtKObMTN
 yGmgE5wSbfuDsmft2G2qQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JjeO/0DjZH8=;mKAUDol7iAv61TW1DGQ/Pj321tx
 e9onCja0JGlN1l5tuR4ro9VryKXUcWtrmcM7akPVzG1mtV+bX3YdNStT+LdFhjCGLOvROSy1d
 IYj1+/zTdTiD8NHAjxbUdEiG8iDfoEKUm32Wz4WmvkauedtesyI+Tulxkm334lpnuxWfYMXji
 Lpjl6NT0FnLm9XPSI66bF5A7PsFdjG1DbqwULfcQUx/y0NiNSyJhEW7oKXgme2wxarUrANf9q
 Jskbi5SudYyWTbaKGxZhRr5sCgNdeRHs/R0i5dzMnFSC8YGltDJeaW9MB/kwFLAjbhbhvA2+D
 jMJRb8fhd7Vjlp89hsFgIt5RL48xGJX7CN0fm8tqdxAEmyvcISuMppq096nkx4sHIiXZ5gg/i
 NdPpfjWfpeabZmsCoJldsMr3v5HmQG/nJVfmXFFqq+FW+i+MWR66VlcISE5k9TLfplbt0A9nI
 pQDTL4ZcCrom2oFRHqXMor//7D5QGUE1V10S9gyOR4gyOCu07j1SN2l2uppo8X0+McS0APFkK
 2UIhXNiM7GpI8Ggiqoffy2o7Kqyj91ArmpWoLKOngCs3hhnhYjTOMF35162s0FnY72DZRaEtU
 j8LsWgDd3PzQsloiPL6cTfRFqwTp2I6NJyjiifpBn0l2smDscYDW9OHTNzuHRcwbyWDlcXXLC
 7GvCWBj5aMFXEeoKp4tT+WgE0U9U0qcMPlbpN/MINvMrI/9X66QiA7u7mh//mTesS00IPE3Gg
 z7VPPIKl/UdsUTEA/eJvcBYeuVm4VukgjZMJ+IzYlGVNXdjBDTY3p+jyI7lXr771dc4lJZ7Xp
 EDgo+6EjBVA1Wwb+MsCBd02YrpnkEeuMA8xYBwjjluf3k=

I find that a cover letter can be helpful for the presented patch series.


> As we first take the lock with spin_lock_irqsave in msgdma_tasklet, Lock=
dep
=E2=80=A6

I suggest to move the last word into the subsequent text line.

Regards,
Markus

