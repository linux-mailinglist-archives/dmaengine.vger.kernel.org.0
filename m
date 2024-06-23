Return-Path: <dmaengine+bounces-2508-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D4D913AD0
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2024 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3231C20BB0
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2024 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF534CE5;
	Sun, 23 Jun 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wN4/hwbs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DD2BB12;
	Sun, 23 Jun 2024 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719149045; cv=none; b=BLIbz1ovIz4WtEYZHwjv0IonYMgvuUL+SKg659WvLlJTgdFYdrTbc+HeBquJn6o5FAhP82ZIaN6yTREqK0bcTH9yCf/8tyrO85WTVoY/nq+uJS3J7msFs5jZMTJGzNFENF2JBMsnsrHe0kdRbF48H1DW6WJbLikPoi6tQpCJ90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719149045; c=relaxed/simple;
	bh=uIgRrYUXNDJDOrgYRkjHQ01AEspYqECWLXYq3Xcg63I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jRcRpfQVJPOdCSrbaaoZ8mtoDDQK3ZEl73uKMwORn82xrAyezCNJ3poKfIny0r+kA7MP4u1B0N8CkH+lS+Beq7bd2m/GZfWZyfyGQY2+g66mr8xnJ69ssiZrBj4tpYcickLI6eLL5NA4OxmN2smcP3Sw35y42Egoc8vpGqJhX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wN4/hwbs; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719149021; x=1719753821; i=markus.elfring@web.de;
	bh=Kr4f4rhX/zKNzyS3gsmrvMsM4ABjIpMgjRGdSS4sZlo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wN4/hwbsS/eN5wkizmcH86XbSR0P7RvhgpagZnKZY8i1tm2KM9HbAfi9DoO4HDmg
	 1RJ0exCXAXw7jjLEqtkvUyqjhexure4Oc8nE9anzgtzuHuhLke4lzsSegdWU8b7Nt
	 1WikChUwNswHkk/kPDSW4wVcEUMwT0kbTxMmN5DoAWNJRnLkYh23882dI9vahX8qK
	 28KgPPHYkUvEm4O/tOjWwWEEHpzSRFRD6CKHgRnHkxCf5NZPR1KJWiUcHyHN+B4mA
	 RwIX7F0ik95yt5s7XLbkJn2axSj/y/96VbSmfn61cykmYPzRGexW6P8y1u6i21eqQ
	 nh8bfuMSF2ot9nIVwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gXO-1sQVsl1Cmg-00xryb; Sun, 23
 Jun 2024 15:23:41 +0200
Message-ID: <eaf19171-ef94-4370-a774-1f67d0eb878d@web.de>
Date: Sun, 23 Jun 2024 15:23:40 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, dmaengine@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240623081644.2089695-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: axi-dmac: Add check for dma_set_max_seg_size
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240623081644.2089695-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HAs2hTH6TCuZkckIPYbOY9C8VnvxSIQzKB7ZHEBwEZfwRcfZteg
 K9DTFXFLw2UhfanRhha/XpJVlGu7XdTLurbqEUfkTIxt83QStHF3loiypsQoYGelVQW7Tqz
 Ygds/CoH2WifG91n4kUS0NiSKMvzZy4byGd1GeLGt3mQe0zlhvzKXT3fCgSRhv15QoCq77r
 fJAuCzFGN2GCx0emgEAJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AUb8ei8cn7k=;ahKl4M8bB7Zjbvzbwvj30hCXK5l
 pCP7qhrElxl2nnVvXSsvwO4KyXaND2Yexi+9zp4D1TYyru+WHutidHOl2wGM5ogG3bLbQTtVV
 SAeR08w8ZV8cfj9dt5taxtsppD2hnVYGfaru2IRmqHpTA5hN2gQiDLo11N/vGUusBvUflnX47
 mm4un7BTgDtKOcbKHChLS9AcLFhdqYH4hpNrZcBGiuh1I5Qd01IsVQaKOSx8pWQnWqgOIzJFd
 z4DyU3/FzXr9Zjjvmr5MA6S/Nj9Gdq9/snlbhNlI3G6jdmKsoh/cQyexWVKhjR51/FmfZMpnl
 YiOlI2WAfV5HDLD53/nIUJ22iroWvu8IcyhTSrYBOsBeRbBBFtYWLlv36VlSgFKp8b6XWsFw3
 QRU478L6WAW/WRz4LsaSZLAMtBU/shUQ0D0C72SYPsT032oYPDShea1gZOO1jX6fgcYfczqBv
 W5Xn56viKfvCBpEK+ttgxK41TCchNt9o7yc3xWYZdGfXTysGqI6ArB+uSlKNVB9FalZlwIAdE
 jITskAiPG2qc8j3Z8j9d1vPwxlbTbwIYErlLlMeqc2YFEzUwISy7pD7O6NGGVhYFzi6BYu2lp
 AUUjQu1Sl8D5Y8Pd94Mc1L/5oc9J78IDRsKp9i0tgDF/sav+Xw2bg2h4yCX/eC35OrqdZ83i/
 NO0q6yCxV02rbIebAzbS6iKPjWapoxOsx3D5Ujo+R4N/kEuW+SEfNovS+RpsT7+ePn/QFyT7t
 u5lgr+dBDfu3ovGr/MPy/L2ZN2xa5E58lJWTXq0Pu/PF1b79pjN17PGytZtnwTBDM1gl+ihRL
 iZtZ5dD/Qn26CSEsUIqWaP/6xVF74vc57I+W3o3iiXHjc=

> To avoid possible failure of the dma_set_max_seg_size(),

Really?

It is desirable to detect a failed function call, isn't it?


> we should better check the return value of the dma_set_max_seg_size().

1. Please choose an imperative wording for an improved change description.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n94

2. Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?

3. How do you think about to append the text =E2=80=9C() in axi_dmac_probe=
()=E2=80=9D
   to the summary phrase?


Regards,
Markus

