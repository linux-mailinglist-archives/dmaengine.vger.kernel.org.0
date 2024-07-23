Return-Path: <dmaengine+bounces-2729-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28B93A3C2
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9041C2286F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139315359A;
	Tue, 23 Jul 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=brightsigninfo.onmicrosoft.com header.i=@brightsigninfo.onmicrosoft.com header.b="qLKRLarF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5B3D55D
	for <dmaengine@vger.kernel.org>; Tue, 23 Jul 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748508; cv=fail; b=uu+Qj0iS/brEUeMKgGZLPo0qkF4stKeqnJ3UKBZCB1+5tCR/iA4RTqGS97roWlX0DjQiQe0MLB/WCBNKSvc2d0TtdrDgN86rTb6fOUJSk04LTbRxOZG6DhdIwcdUIDVkoAAMWDUfyvAf7YPmz0yRSqdS/E9KoWmb06Btx1dYIp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748508; c=relaxed/simple;
	bh=Rd6Te19gAscdi4jjp85CfocITyyFoKRsfpJK5iuaWNU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gkLTp4W6bRhOvBeF2mdFT5jxMPT7ws4lyWAbTL8EXOh8sxHmhW7LTQlDUevSde7KbMmTqL0iaZERV7kdvBptUzZCbEdjC3Zn3fC8FvzSH26wQL03BzfBE73jPE+DFf2/uy5cHknDqQcJLXmyj9HmcSxcBoE2hHBZluGJfhuZBjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=brightsign.biz; spf=pass smtp.mailfrom=brightsign.biz; dkim=pass (1024-bit key) header.d=brightsigninfo.onmicrosoft.com header.i=@brightsigninfo.onmicrosoft.com header.b=qLKRLarF; arc=fail smtp.client-ip=40.107.93.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=brightsign.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brightsign.biz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL+XfhtTtKRNw43hAQc35WAQubGyx2c0Ws75iBJLzRIBRBCnhDqFCZ3N9ke4+sincmVdgsftqKSlDJT2NOZKS4krlj1rDcuz9A7rOEAAUk+itdmzrO0UQ/N/E8lV9P1gxTCGK/E3sQyJZOc18svBCF1xk9J1Cz0OvUcDM2gjwCfo06fhsJIKidKHgdXCyXH7CdPmbu0McLNSBmvxic7+nil7VeWvYpqdPA2KAv8HJSzwOYU7FzWtw5i3DTsIj9rx/eFKIFfnxhz0SteHJ9MgfBjKUe8PgftPRD3JhbbOgMKA6/bLP6CQTsQq94nvGPnT+c5WvgCFisURFuwcY46d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+rx23HDtxctdCdTu5G4RT1mCKlm2O7m8GKJBVwHv0A=;
 b=gqYK9N7GPH64J5A/MQaedTabPLkPCkxkEPQP+TGBlLD62QCBfBALjFzA8Z2CjfAOn5bV0llZ4av2mLCOLcL02aIflL+ddHXSWR7VTKI4ljFfBAMQ4AK2btLM3gshMd7cGdLDezkcGRd5fBdAy47B5e83tUYcBCNHMjtaaRatOjtGEEa1IcATvXmq6P/ddSerRoUAkFMn/1J9Tcmwd3LO8SJGVlHY4qafMr9yBHVYBnhtKRg/VwuwBfI4/R0puaLvCvCisG/DU8mKT9thSOsLYr9HNiVDdskzpmPnwaoo8G/N7lc14FrawcU2BjFaRA7qr86EsipbITqNXWvIl4YdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=brightsign.biz; dmarc=pass action=none
 header.from=brightsign.biz; dkim=pass header.d=brightsign.biz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brightsigninfo.onmicrosoft.com; s=selector2-brightsigninfo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+rx23HDtxctdCdTu5G4RT1mCKlm2O7m8GKJBVwHv0A=;
 b=qLKRLarFHxpzlL2C8R9FcqusOsolLZLwWb8na3GDdb1eD+OxTBLPS8cMWNVNiXrahXnrIPvN/71rmmZxhzrnXXmhdhwUA2E1RESQh99kzuK+qvT2/shC6CEPrsJKpBOyLNbD7jGCY+YOks2U1TX78c5ar24b51cFdW38dckGOss=
Received: from BLAPR22MB2243.namprd22.prod.outlook.com (2603:10b6:208:270::11)
 by DM4PR22MB3743.namprd22.prod.outlook.com (2603:10b6:8:42::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.15; Tue, 23 Jul 2024 15:28:21 +0000
Received: from BLAPR22MB2243.namprd22.prod.outlook.com
 ([fe80::50d9:71fc:2474:7103]) by BLAPR22MB2243.namprd22.prod.outlook.com
 ([fe80::50d9:71fc:2474:7103%3]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 15:28:21 +0000
From: Chris Pringle <cpringle@brightsign.biz>
To: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: pl330: peripheral read corruption on cyclic buffers
Thread-Topic: pl330: peripheral read corruption on cyclic buffers
Thread-Index: Adrc6XrFtkcxaEB8SkW6GCuZBJ04Rg==
Date: Tue, 23 Jul 2024 15:28:21 +0000
Message-ID:
 <BLAPR22MB2243B9158BCC7665034808B4BCA92@BLAPR22MB2243.namprd22.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=brightsign.biz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR22MB2243:EE_|DM4PR22MB3743:EE_
x-ms-office365-filtering-correlation-id: 9fec283c-19b5-47f8-7edd-08dcab2c1619
x-ms-exchange-atpmessageproperties: SA
x-ipw-groupmember: False
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UJ0/JL1C2uUghf1HD/Z/cENauy5zamgIqzlC2tkBIPDS7MG2qTD4KxtBVW7e?=
 =?us-ascii?Q?sr6j9V84i45h4WOpyeIF9/Y3bCzSiaOaVvivpEIouHWZr0n+IdYS2xvS8Y4N?=
 =?us-ascii?Q?HkI79ye6G1nHxO2cOCsjy71ePIXuMvh9FkzoDiy0RCp0Xu1HTHXW7dRMy53G?=
 =?us-ascii?Q?VCfqPCg8jLSJ4l/IELOZsaSUFQDSMZw0ptsIckDoDbz3Pdt9XTwh/19KTjM3?=
 =?us-ascii?Q?bSphnQ2kPAHRuc2xNxWQY+LY8ovxyZ1EUtp4114/LZZF6Td77J/QuNPEqbgZ?=
 =?us-ascii?Q?VzaufpVJ27E/Rs3mxsjbfPzoyxCUP7ZUkoUL0UuXg6NRFSqEdemHAWidQuP/?=
 =?us-ascii?Q?3LHu3JpaEW7WT+02yYHDQvKb6p7cVf3vmB5Mz9oNMR6CjO9CL3uF5OqB6V8m?=
 =?us-ascii?Q?qDmLFfaJ6nnVwVJPSIZJhqCkr71gpPq9RYdQEKBThk2JEDtVhUM6clYVvvcY?=
 =?us-ascii?Q?eWlYyU9G6lerkEXC8dAnHv9wjoyAxfpHnGGKEKzb9DCHd5N+qKeGUBJIwJfS?=
 =?us-ascii?Q?b1rybPHxSTrGTgAcgB0i+lczWpEpbcM1GX1mGE0vyCnhwW7qUzbG/t72srG8?=
 =?us-ascii?Q?herD4ZnCMvkuyW7CQJBz8yUcWieGZ6l8CHXs+fKPIQP2ik+6R6AIIE5GPh/e?=
 =?us-ascii?Q?LuUdqWebdUMtgI5tVP5eBZmzGVMQ5pa8sNx17IA8fEM0ATjiYsQi6hLK731l?=
 =?us-ascii?Q?Rro5Z1s0oX/qD0NA+S3mduEAdiuerzcLsEzAmSj8ON7KM++K2jrOamFbRu56?=
 =?us-ascii?Q?YzgETXjhR9ATlpdl3libyAhzRXyvDmpclZTLIQFA+3UJ6eD+PP8sSov/wz1i?=
 =?us-ascii?Q?4gV9LfeY6Mm5mRRRQ+tNTrP0ke92wuzzC2tiJrDxrCMTPNLutLYMng1H1sCf?=
 =?us-ascii?Q?PB5QLnsAA1DRJlZAC4Ekl7JNl1y1MnkFivf+ZB1vwn/j7Euf6QBQV7Vxjf2v?=
 =?us-ascii?Q?6lG5OJqAtY11o73BKDQNva6V4VhcbQJBnWV4mqDBiIBBup8++HO1ozWVOvSp?=
 =?us-ascii?Q?CoVCqiVjBVCxBNgJ6PT28UszkyDv7aaQpFb0qyP0xhT3D7uLJyBdzjl5qu6f?=
 =?us-ascii?Q?ivDkiBisNQ1x/zxhKobdIvZq79Dj3STzF1AQCUex/bu5HRJuVvQ85J7JEu4+?=
 =?us-ascii?Q?sXCD3LEzDalUoRos7d7HSHOslywxHfhmVt9kZGI0qh5LxlbE0r2tZ1m+atQQ?=
 =?us-ascii?Q?noSm1d4ms5WZCJg95Yc8Yvf8gZfpEOmU+K8BsMSG1StfirBRVkP+KvxKtJzb?=
 =?us-ascii?Q?QDzMYYMy4ImsGwpFosS3opiM2iFUcNdDWNT+JsLXC14Z1IhmEu/NZkqehBQe?=
 =?us-ascii?Q?VSAzdAIq2t68R5fzzzGaRoTTbMmlWQ7nQOLa7Rh7F0Hwi2OnnqsvJXR+OL/Q?=
 =?us-ascii?Q?qvlC0E+1RGnZxyEUzSBjyh7+iSJ0fV4mmFeBzica/LXmV8enQw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR22MB2243.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s30u0nkgcNLaDnmpRHNeJAghf5VCCy1Bq4n+fyO9OaOth9MSFkytUj1xUcT8?=
 =?us-ascii?Q?IOGJ0EiikofH9tGbVbaxHNnVRpBNk/q1Nz/6ZXwr2Soan7uCfoHbgezopPg3?=
 =?us-ascii?Q?MKv3LKSos0mOLoCJxCN2tW5qz8BIv8P5WJT0XnPmF+V7S/wAXlP1W15PTy3T?=
 =?us-ascii?Q?pQknprh8EmiNz7tBJ9pSXHmkMEDsPf/olFCrd7mY6k1rf1j4HNZlpLiCAFyF?=
 =?us-ascii?Q?c6IlUYtT9nQiqzxgxirhqN+FxRN6m63XF3TTA2Qhcc9d9QLECvhf2vxjcUbS?=
 =?us-ascii?Q?a4nuktixR151MWnDiPhm1puxq8wmrfU0wsE4E44U9pCQl4IP6Mda8jryXSuW?=
 =?us-ascii?Q?guWUW2N9DEA3RhoQ7DsqQEwBzRivJbs9annZnOEkMKTs+5oA0YmqbYQ+wMtU?=
 =?us-ascii?Q?RO/FxcOo5VLqV5pksMR1FjXIaPz7RxkHoiC8brwRmReq9MKMaHPs/f7aWL7z?=
 =?us-ascii?Q?LRWdHf4nMxcNZ4eym+CYvuymRTUzWStC83laaUpaIRK5bw+qOfh+hhJ7hTMs?=
 =?us-ascii?Q?jZ1FG+uo9XrbDsuaWinxucDrvEiyc4sw3OFN6QejBqEbh4JRzIZdWYW5j2Vx?=
 =?us-ascii?Q?w9EKupM/o76++Ipyv0idhMKAQj9iwPt1Exzivco+8CqwjSBse4lEt+liCI5I?=
 =?us-ascii?Q?yWdGc4vAiJovty92a8o1JaNEP0KMtXMus/Kg175QtFGCujwcowiA3MSXKwyK?=
 =?us-ascii?Q?uN+3yuJ/LWtq9HJjPFENj5sYYR+yZm7MXewwUwKpJwC/Y5cZdqqUEcta0ytX?=
 =?us-ascii?Q?T/GVrJmAEdg3PDMwo99pstCYfgXhutrgurQIdD+Z5TmupJpY3TBBKS+Cr5NJ?=
 =?us-ascii?Q?JihP5SH39zkqs0uwQ7WoPrMioeCfD+XLwnNRplryQTD6J3lq75D2A7LY/s7v?=
 =?us-ascii?Q?wV2Ztt0umS4yKP3s8X792me+ZSXNHaKWhiBlfMSPllmHZoQtvCaGdEtBPpSY?=
 =?us-ascii?Q?IQ3fKs/Kki1eKhRlRuV7g2mUEOq8/kaY7UPL8XbMp3qLsjtazT6yAT6yvrQY?=
 =?us-ascii?Q?OL0MQFlKfs995wLIgV9vNXnORRXzZq2JdulSTQ2xEbpB9xYbjfIypnYskOUa?=
 =?us-ascii?Q?elb/WdM/iY/DCTxaM/67nEp6Fp1yUORY1uukTh+1+6X6HuE7LbL0RnHHt06V?=
 =?us-ascii?Q?M61DTL2J12rqtqSr+nn+MpnpU46hwv8LCieGgatQOpmajCAfu+JPf5PBmEVy?=
 =?us-ascii?Q?2Elux63OiH0OEmLoS1DuXom/C4pS143ZtoO+l7TRkVneqFaaKBjUJPkIE+8Y?=
 =?us-ascii?Q?+3MQ4UeEooQpTZ2qcpMDqXNaI/vL/82FzketuJnyIUtmmsSXM8RPm6FQyBM1?=
 =?us-ascii?Q?twH2dmFwUPqkLOuA+dQ+hx8plSaGMitmg/EV1uPB7qzbWw8rIduWw38iq4rG?=
 =?us-ascii?Q?EuuU54vhm7ziI5Ai9BqsnlDDkaM/6iCRfDusPL9U6bHS9QePlvhtrf49ABOK?=
 =?us-ascii?Q?s8esJJFhNUGtTD5oOcgBXhKwyhaKlI1YC+skXI9tAtTz6ewHEsAS25oZTSL2?=
 =?us-ascii?Q?np3Jk6byhC3DVn81z+73IVp2ZRHDeaFeWFhdC15iEsjZzE+NGvqoYTSupFw/?=
 =?us-ascii?Q?108y2TEdeOGz1m1I/1wV+PKUGaeEJ3si51diEjgu+Z8TRdLCQ+BGup7xAxUZ?=
 =?us-ascii?Q?R24xY0CerXhe0cfjwiQ0OLLfqXOz/D8BQVcYDfsLuKPo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: brightsign.biz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR22MB2243.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fec283c-19b5-47f8-7edd-08dcab2c1619
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 15:28:21.7219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpaZhx3evmqn6/ke63cJMq/h8qOJOV+dy5GQnoN/3XmohCFKY/t/OiA3qSkomjEjamwP20Ow3XDaVhvzl6vY9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3743

When trying to perform cyclic DMA reads using the pl330, I found that porti=
ons of the data read back from the peripheral are stale/incomplete at the p=
oint of reading. The pattern of corruption in the data looks like a coheren=
cy issue; in our case, with a single read of 64 bytes of PCM data, I often =
see the first 32 bytes of data is good/coherent, but the second 32 bytes of=
 data is stale (whatever was in the buffer previously). The audio driver we=
're using (via soc-generic-dmaengine-pcm) uses a cyclic DMA buffer for fetc=
hing audio samples; at the point of reading, the pl330 driver works out how=
 much residual data is in the circular buffer by comparing the buffer addre=
ss with the current "destination address" register in the PL330 to see how =
far the PL330 has got through the current DMA transfer; from this the audio=
 driver can derive how much data we can safely read from the cyclic buffer.=
 If I wait around 1uS after reading this "destination address" register bef=
ore reading the data from system memory, the data is always coherent/comple=
te by that point (which offers a potential ugly and perhaps flaky workaroun=
d for our use-case). The issue can also be observed by determining how much=
 data was in the buffer, writing a known test pattern over that data, waiti=
ng 250uS and then reading back that test data; I often see that sections of=
 the buffer (in a similar pattern to those observed with the audio distorti=
on) contain the DMA'd PCM data instead of our test pattern, suggesting that=
 either the DMA isn't complete at the time we wrote our test data.

I'm pretty sure all the existing code in the sound subsystem is already man=
aging coherency correctly, but just for completeness, I forced allocation o=
f the buffer using dma_alloc_coherent (instead of iram) and manually called=
 dma_sync_single_for_cpu on the impacted memory but that didn't address the=
 issue. I also tried adding in full system barriers (i.e. "dsb sy") but tha=
t also made no difference. Reducing the max burst length to 1 exacerbated t=
he issue under normal conditions, but masked the issue once tracing was add=
ed. There are several errata on channel 0 of the PL330 so I excluded that c=
hannel from any testing, which also made no difference. I checked the align=
ment and all looks okay (matching the restrictions laid out in the PL330 TR=
M).

I found that adding a RMB into the PL330 microcode (between the LOADP and t=
he STORE) was sufficient to address this problem, but I am slightly puzzled=
 as to why this is needed. According to the PL330 TRM, the RMB will ensure =
that any existing AXI reads are complete. In this case _ldst_peripheral is =
performing a LOADP (loading data from the peripheral into the DMA FIFO - so=
 not AXI), followed by a STORE (storing data from the DMA FIFO into system =
memory). It is unclear to me why a RMB is required to ensure that all the d=
ata is written at the point we call STORE; the observed behaviour suggests =
that adding a RMB is doing more than just ensuring any AXI reads are comple=
te as to my knowledge, the DMA channel is not performing any AXI reads. I a=
lso tried adding a WMB after the STORE but that didn't resolve the issue. S=
imilarly adding a WMB in place of the RMB (between the LOADP and STORE) als=
o didn't resolve the issue.

We are using Rockchip's kernel source tree and unfortunately testing our us=
e-case on a mainline kernel is a non-trivial amount of work. However, I por=
ted across the latest pl330 driver from the mainline kernel (no changes exc=
ept for a function prototype) and that shows exactly the same behaviour, so=
 I believe the issue is also on mainline. All the drivers involved are part=
 of the Rockchip kernel source tree, and most of them are identical to what=
's on v5.10; the delta between these source trees don't look like they'd ca=
use the types of issues I'm seeing.

Does anyone here have any thoughts on why adding a RMB between the LOADP an=
d the STORE might be fixing this problem? Or conversely have any other thou=
ghts on possible root-causes or suggested fixes. Patch with potential fix f=
or comment below. This patch mirrors exactly what the mem-to-mem DMA does i=
n _ldst_memtomem; it will likely need a bit more work to cater for the REV_=
R1P0 lock-up (like in _ldst_memtomem) but seeking comment on this problem/f=
ix first.

------------

From: Chris Pringle <cpringle@brightsign.biz>
Subject: [PATCH] dma,pl330: fix peripheral DMA read corruption

Fixes corruption observed on DMA reads from a peripheral into a cyclic
buffer. Previously, when trying to read from the peripheral, portions of
the buffer would contain stale/non-coherent data for a period up to 1uS
after pl330_get_current_xferred_count indicated data was available.

This patch addresses this issue by adding memory barriers into the PL330
microcode that handles peripheral loads/stores.

Issue was observed on a RK3588 with HDMI-in PCM audio read via an I2S
peripheral.

Signed-off-by: Chris Pringle <cpringle@brightsign.biz>
---
drivers/dma/pl330.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index dfbf514188f3..427f1c2aa4b3 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1193,8 +1193,10 @@ static inline int _ldst_peripheral(struct pl330_dmac=
 *pl330,
                               off +=3D _emit_WFP(dry_run, &buf[off], cond,=
 pxs->desc->peri);
                               off +=3D _emit_load(dry_run, &buf[off], cond=
, pxs->desc->rqtype,
                                               pxs->desc->peri);
+                              off +=3D _emit_RMB(dry_run, &buf[off]);
                               off +=3D _emit_store(dry_run, &buf[off], con=
d, pxs->desc->rqtype,
                                               pxs->desc->peri);
+                              off +=3D _emit_WMB(dry_run, &buf[off]);
               }

                return off;
--
2.30.2

BrightSign considers your privacy to be very important. The emails you send=
 to us will be protected and secured. Furthermore, we will only use your em=
ail and contact information for the reasons you sent them to us and for tra=
cking how effectively we respond to your requests.

