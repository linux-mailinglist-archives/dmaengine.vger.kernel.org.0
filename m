Return-Path: <dmaengine+bounces-733-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8182C0EF
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jan 2024 14:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B5A1F258D6
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jan 2024 13:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07758ADE;
	Fri, 12 Jan 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ess.eu header.i=@ess.eu header.b="tYJm+iZM"
X-Original-To: dmaengine@vger.kernel.org
Received: from halon2.esss.lu.se (halon2.esss.lu.se [193.11.102.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D122078
	for <dmaengine@vger.kernel.org>; Fri, 12 Jan 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ess.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ess.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ess.eu; s=dec2019;
	h=mime-version:content-transfer-encoding:content-type:in-reply-to:references:
	 message-id:date:subject:cc:to:from:from;
	bh=NuHCV28mB2cgR0ZRLf/ngAaPct9dzN6NmXf3RQ1UEO4=;
	b=tYJm+iZM7ZBk+4HHasXPXGatP07yDC4NPC3GoxkGo+U394mEgT5TRXPcvpIqN7UcN03mCpgtTGu/9
	 eQaYdPJtwaT+Ab5oAzqeC8GoQNwVVPsRZ3jNSTTpeCG6TNbwdqbAVvYx+hgpwlAojl0Y+8rl78l0qM
	 MycG63y8m+ktvxKP79SMg8xmAyfMShVFcao/wFvkWZd+U1Izywpc7J0g39VmTfi+PGa6UwIkXSaPqh
	 I7A6fxNS7TygVqK3jwebMj81Iu4F11/kde8Z7hIK9Ec547ZJKeJiA7NdoY+MnJ9Kr1VHswZqhrrhcb
	 rOG6a6+zI21vIeNOK+jcuaL5GIDU8VQ==
Received: from mail.esss.lu.se (it-exch16-1.esss.lu.se [172.20.90.30])
	by halon2.esss.lu.se (Halon) with ESMTPS
	id 6e087d40-b14f-11ee-bea1-005056a642a7;
	Fri, 12 Jan 2024 13:35:20 +0000 (UTC)
Received: from it-exch16-4.esss.lu.se (172.20.90.33) by it-exch16-1.esss.lu.se
 (172.20.90.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 14:37:33 +0100
Received: from it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859]) by
 it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859%5]) with mapi id
 15.01.2507.035; Fri, 12 Jan 2024 14:37:33 +0100
From: Hinko Kocevar <Hinko.Kocevar@ess.eu>
To: Lizhi Hou <lizhi.hou@amd.com>, "brian.xu@amd.com" <brian.xu@amd.com>,
	"raj.kumar.rampelli@amd.com" <raj.kumar.rampelli@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: XDMA dmaengine driver implementation
Thread-Topic: XDMA dmaengine driver implementation
Thread-Index: AQHaQu9CRAzWBQo8rUKfhSvKtCfsbLDRnvWAgASTHNQ=
Date: Fri, 12 Jan 2024 13:37:32 +0000
Message-ID: <339a8de97f404e169eb5cda9576624bc@ess.eu>
References: <166301ea776347cf994b8e8ae4362352@ess.eu>,<05ff03b7-ed7c-f923-3c44-9c9d60760cbd@amd.com>
In-Reply-To: <05ff03b7-ed7c-f923-3c44-9c9d60760cbd@amd.com>
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

Hi Lizhi,

I found it and managed to reuse its DMA interface within the dma_ip_drivers=
 xdma driver.

At the moment I've hacked the dma_ip_drivers xdma driver just enough that i=
t is using the xdma dmaengine instead of most of the code in libxdma.c.

Thank,
//hinko
________________________________________
From: Lizhi Hou <lizhi.hou@amd.com>
Sent: Tuesday, January 9, 2024 5:42:13 PM
To: Hinko Kocevar; brian.xu@amd.com; raj.kumar.rampelli@amd.com
Cc: dmaengine@vger.kernel.org
Subject: Re: XDMA dmaengine driver implementation

Hi Hinko,

mgb4 driver which uses XDMA in mainline kernel. Please see:
https://github.com/torvalds/linux/blob/master/drivers/media/pci/mgb4/mgb4_c=
ore.c#L437

Thanks,

Lizhi

On 1/9/24 03:30, Hinko Kocevar wrote:
> Hi,
>
> here at ESS we are using https://github.com/Xilinx/dma_ip_drivers/tree/ma=
ster/XDMA/linux-kernel kernel driver today with the micro TCA based data ac=
quisition cards such as https://innovation.desy.de/technologies/microtca/bo=
ards/damc_fmc2zup/index_eng.html and https://www.struck.de/sis8300.html. Th=
e diver seems to be functioning just fine and it provides all the necessary=
 software interfaces we desire.
>
> Looking at the https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmae=
ngine.git/ I noticed that there is a lot of effort in getting the XDMA dmae=
ngine accepted into mainline kernel. As far as I understand one would need =
to develop an additional driver that utilizes the XDMA dmaengine driver.
>
> Is there a reference implementation of a driver that uses XDMA dmaengine =
that is similar to the on in dma_ip_drivers github repo?
>
> Thank you in advance!
> //hinko
>
>
>
>
>
> Hinko Kocevar
>
> Beam Diagnostics Engineer
> European Spallation Source ERIC
> Odarsl=F6vsv=E4gen 113, SE-224 84 Lund, Sweden
> E-mail: hinko.kocevar@ess.eu
>

