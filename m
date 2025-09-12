Return-Path: <dmaengine+bounces-6499-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21485B5555C
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 19:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49BA564C00
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC75321F40;
	Fri, 12 Sep 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FbeS5Wjk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265738DD3;
	Fri, 12 Sep 2025 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697122; cv=none; b=n6b1/Jx9+caOMcCEN5GVAm57TBsPy7R+Sd0mjhgn4crKydiV7gSdCOtEl/WWX7XzwvctZcwbJFPfL62eLiBK4ozzieKz/N+jbyizNEJNfjP1DMPxYwKsRjg8Y9H/CDgxFQYQKdSOPAIVRv3VyfedwPSItTSCJKQ9fMMSUhLwsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697122; c=relaxed/simple;
	bh=wW5m0qKyXgfCHRmC2pD02cpExwdhP4xP8WOnkMryiqE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rnAXrKOEV5BmLrlzxG+02O/7oeIer6QgLad5pSmL33NJF8eD21Ur87J3LuNjJ1aBjtsTc1r7Snkj3LgeTEt1iJZyB/rrp2qnMgZRihO8d5n4sxxJbqP801O+EbsC4GXiPcqgLFdYRGveXFLeGMJDFFJGd+RpBIqA7BJ5zNVeY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FbeS5Wjk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757697118; x=1758301918; i=markus.elfring@web.de;
	bh=i4TCn0XsEoHWr7pRbnY+4cg5mG4aNm/ybD0AcBDI5Pk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FbeS5WjkTo318Axy6gQDcYYqqulBbMzCG2s8toFYT1msNsyXdxw73ZT3YmXTA0RK
	 xcPdMao7/tDfZ79BxcMNxbDc/ZvdJ59QztxBxIsBU4tzi1sjv030ij1OxyoeoCVal
	 a76tcqKwl4oBb9DwbQv7wcAXtadEaSBxVCznKINLqCqKrXM2EqGPgsRMwMzaVAW2n
	 VTBBQLtFw+O8pZ8HW/AwBr7aUaCw7hKm2hhNXoMyhdS6vhHueO0SucdMFs7Uchc1g
	 IPbM4So1A1jSbXZBD2OKQjx/Ii2XsyS96xXgWYcmV91sQaC4Lb68AT1hPZGNMFwac
	 EpJ+/SjCx8OAeaRZDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.219]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsON-1uXiAv27u7-00ZfeZ; Fri, 12
 Sep 2025 19:06:22 +0200
Message-ID: <623167da-baed-49bd-a6b7-932bdb43bd25@web.de>
Date: Fri, 12 Sep 2025 19:06:20 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zilin Guan <zilin@seu.edu.cn>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jianhao Xu <jianhao.xu@seu.edu.cn>,
 Vinod Koul <vkoul@kernel.org>
References: <20250912150132.127135-1-zilin@seu.edu.cn>
Subject: Re: [PATCH] drivers/dma: replace dma_free_coherent with dma_free_wc
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250912150132.127135-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4gpudNgBVCJVFh/0UF/44b8tAVIP+o7oSVuOSNXSX5+TZVnL5En
 6J1idRFKvNxmdHyx7TBKrdaIU6O2lcjtYCimmX3aLdhBm9lWDbq+9A4qbwKhGUjW4jqA3NW
 +aRhstwQjc/u16vMvzLWm/3QaUoe3h3kFBaLBiTbGc7DdJIKSIIw8OfbKs69rlC6RsXDoTs
 9t0qn3wTNtuEBgtB/zUnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dl3OCCav/Y8=;hqw4eT3/pWCvbtUoVGyVYSXDkqj
 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

=E2=80=A6
> The fix is to use dma_free_wc to match the allocation function.

* See also:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n94

* Would it be helpful to append parentheses to function names?

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?


Regards,
Markus

