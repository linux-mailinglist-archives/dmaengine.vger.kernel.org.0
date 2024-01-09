Return-Path: <dmaengine+bounces-707-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9890828534
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jan 2024 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98E21C23811
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jan 2024 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB6237145;
	Tue,  9 Jan 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ess.eu header.i=@ess.eu header.b="qV5HRsVT"
X-Original-To: dmaengine@vger.kernel.org
Received: from halon2.esss.lu.se (halon2.esss.lu.se [193.11.102.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A336AFB
	for <dmaengine@vger.kernel.org>; Tue,  9 Jan 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ess.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ess.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ess.eu; s=dec2019;
	h=mime-version:content-transfer-encoding:content-type:message-id:date:subject:
	 cc:to:from:from;
	bh=fiZ4/zWtUfTbydiYubq8JPXEJYGVoNJn3Th2dMrG86s=;
	b=qV5HRsVTPb1+sHx/qpDAcEjB/L7v0a3rvINjcO2GySRK7MjDF14VuGMCmcvVrotZLo8OZVDHoyeIi
	 vnJ4SSHN6voQBXcPx80dLr+cjr4rE2esWVRPHsfaVcSSiRBgLitq4HpdbQmPhN6q2hfdKKeyHUG+Qt
	 8WeWDPTc74KixZ8fqk1sjoTPN7HqAiBeigqklM7pal5PQ16NYYEkifFHzGk8/0SyXlcKFmAbahU+tv
	 OguKZD9xL7mqIC13a2l+Rldc3N7PIniPK7s2MD6mBmLeGqEABYG1JuYHBOHTjbCIohH+ZEQ13a3f+0
	 8llYyPcx7lDURjxMKMi4+P6nfsVsh/w==
Received: from mail.esss.lu.se (it-exch16-3.esss.lu.se [10.0.42.133])
	by halon2.esss.lu.se (Halon) with ESMTPS
	id 338550f4-aee2-11ee-bea1-005056a642a7;
	Tue, 09 Jan 2024 11:28:24 +0000 (UTC)
Received: from it-exch16-4.esss.lu.se (10.0.42.134) by it-exch16-3.esss.lu.se
 (10.0.42.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 12:30:38 +0100
Received: from it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859]) by
 it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859%4]) with mapi id
 15.01.2507.035; Tue, 9 Jan 2024 12:30:38 +0100
From: Hinko Kocevar <Hinko.Kocevar@ess.eu>
To: "lizhi.hou@amd.com" <lizhi.hou@amd.com>, "brian.xu@amd.com"
	<brian.xu@amd.com>, "raj.kumar.rampelli@amd.com" <raj.kumar.rampelli@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: XDMA dmaengine driver implementation
Thread-Topic: XDMA dmaengine driver implementation
Thread-Index: AQHaQu9CRAzWBQo8rUKfhSvKtCfsbA==
Date: Tue, 9 Jan 2024 11:30:37 +0000
Message-ID: <166301ea776347cf994b8e8ae4362352@ess.eu>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

here at ESS we are using https://github.com/Xilinx/dma_ip_drivers/tree/mast=
er/XDMA/linux-kernel kernel driver today with the micro TCA based data acqu=
isition cards such as https://innovation.desy.de/technologies/microtca/boar=
ds/damc_fmc2zup/index_eng.html and https://www.struck.de/sis8300.html. The =
diver seems to be functioning just fine and it provides all the necessary s=
oftware interfaces we desire.

Looking at the https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaeng=
ine.git/ I noticed that there is a lot of effort in getting the XDMA dmaeng=
ine accepted into mainline kernel. As far as I understand one would need to=
 develop an additional driver that utilizes the XDMA dmaengine driver.

Is there a reference implementation of a driver that uses XDMA dmaengine th=
at is similar to the on in dma_ip_drivers github repo?

Thank you in advance!
//hinko





Hinko Kocevar

Beam Diagnostics Engineer
European Spallation Source ERIC
Odarsl=F6vsv=E4gen 113, SE-224 84 Lund, Sweden
E-mail: hinko.kocevar@ess.eu


