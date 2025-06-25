Return-Path: <dmaengine+bounces-5611-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF34AE76D2
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 08:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE0F189D553
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98451E5B95;
	Wed, 25 Jun 2025 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U5ZKb8CW"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA6800;
	Wed, 25 Jun 2025 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750832074; cv=fail; b=W4sIOvI4JTVxKmcK8Oq5tNei9ROtKWvAmRQE7y/KRw5+qMrBllqe27dv+V058t/7oo9dE+a/T/YkhxHzXA5MP5NlpCiGXAxXr0ZEFA84cBdNIMhavz89fG4oc0ZC6ynquRzXVmzkUmYvaNGe8L+miJ+uuHnEEL5tfo6K+gWRRLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750832074; c=relaxed/simple;
	bh=Ksj6csdsngtzT3h2k188v0ICUVYEi+6SQAd5IUUSSxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJN8XkBBUCukNbPizIesV+kfkdWheQzql7cV6nRpso1jlJMXHAGqYLIfME2T/alj1kFK/QBGKZpFc195jDGFhI1FZnn7pdOVAFktshr3Wn7/nL08NJwvqOAS5nNCvUwrvynAEGH5zGRmJkWI3tYahxHD0jw+nGPAtQUteX+TTHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U5ZKb8CW; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q74NmKTyYPc/GCj5WtQamaHZmb9pbGEPAnkk1+pkqSyTGhcpLChtmwOYmgWvu94/sbFx8baYX+WSQcLZqylgJPRCnwzO1qcKuStvHB/iWew3uXHkHPaF+I0QZPc/jW7hFb7X/ufM6GSz0CMlyJflvCZBldx/UYbQgZN12CoR1nMmb9bVgd/c82KYMlgDQERscUnS1lbqsaysaQRdMC0/MhgMtGmRn+pxrd4y8e1T4kyeJJt/B2aEDgqTIvB9AB+oAdG0oFOjCCTyNpf4Qh/deRu49HW6n9HeZ3ASPE7nCbGXHaq8BcdMTOz4z1qbdFqRIrJrVDQw8S9d1XxbF3rYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THKQM3lioLgdKzFLuDysp+6/MIsjHqCbOsVr90N0XQI=;
 b=aslKIEmw0ICnvqhioPQaN6QZIlYccgvFxrXfJXx/VIdZV91vf4Hq0oHkkTqDneLscxzli310VbODPXccfHKGrPjAl17iUxMKgYo4rKk81dWVUnorLBco/0+X1og9FmI+9mmE79o6rLCtJomL//zgASe3CaIAR86dZHCmmIzYpBVb+69pyFyNah90bd0gWKtMuIlC9RUoTQMOmjgQ6/sICDZKKg1xTwoTrHc0WEC2BXOpGiCLd+9Nt0RrWclxiYMLJN6j5k89u6tlJPJgR3bUNJ4EuWUsWDNHWRWW6Dv7kLvjQCa+zg5Qagt6kvPvc7YIqLTFVbh0pssOlf32fPEqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THKQM3lioLgdKzFLuDysp+6/MIsjHqCbOsVr90N0XQI=;
 b=U5ZKb8CWQp/s3JdhSWHuQKSziVcWFFhLH/iCCWuuHEbbEnYlu0G7dQeU0/UASGgfhHFkhBcqresFLl02QY4HfME6fJ84qWSOxrOvjSDtuMWbRctdTXdcXbhJml+wWv2TNcinHCIzLquG5VMXnzsmDYydHDJkTuiD/U/sTQbopPo=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 06:14:30 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 06:14:29 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Folker Schwesinger <dev@folker-schwesinger.de>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>, Marek Vasut <marex@denx.de>, "Pandey, Radhey
 Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: [PATCH v2] dmaengine: xilinx_dma: Support descriptor setup from
 dma_vecs
Thread-Topic: [PATCH v2] dmaengine: xilinx_dma: Support descriptor setup from
 dma_vecs
Thread-Index: AQHb4OnvJYMjm4W4b0Ou3L/AIIB3nrQTbf8g
Date: Wed, 25 Jun 2025 06:14:29 +0000
Message-ID:
 <BL3PR12MB65714A495A20FE6C955D80E5C97BA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <DAQB7EU7UXR3.Z07Q6JQ1V67Y@folker-schwesinger.de>
In-Reply-To: <DAQB7EU7UXR3.Z07Q6JQ1V67Y@folker-schwesinger.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-25T06:12:56.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|IA0PR12MB8648:EE_
x-ms-office365-filtering-correlation-id: e11cbf44-7e45-4162-8104-08ddb3af8b84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BVTI1bV7TbhRMEeh9WHNyNI5IpTWD1L+x9rTHC5k0rKNZj6cgZ7Edy+4Eh?=
 =?iso-8859-1?Q?nitf+JTK5CROng/CpL+p+vwS51JXKEQ1rvekgkoTEUAgHSPGapbqUTLnk0?=
 =?iso-8859-1?Q?wqBF0gr5NKiC2J+SVWk47Vdwel16m42wJrUeGLhLSw2GU+1L0/Faf8avVD?=
 =?iso-8859-1?Q?fWR3ppGxHDGRbyAvBfHRtwTltBogufX6C8utAdeVzLinzS7+kCkALAXlFH?=
 =?iso-8859-1?Q?FZwnMovLZt8XEEBE2GNC7mQyMvmCa2GT+2XDeHymAtXzTPyRklqOAvZnpS?=
 =?iso-8859-1?Q?ZR9TI4KP1Zqz6g2hUVO2VYJnbXLQCKyuozXGw8nmoymm2wFbXfnLayggA2?=
 =?iso-8859-1?Q?tyIT4xcuLwVlODgr/BBWdAtgOzJzPYcEcButfqqcdruY7kPiWn0lasnEH3?=
 =?iso-8859-1?Q?VbZQfDHIlE01GfFcxJsw+fKHlqwstzRJOBwjhJ5wr1t+KmVf63CIOew2om?=
 =?iso-8859-1?Q?8txLWkFMzNdfFCvM+AaIPDi2tRqCP7IT3cmyDTBwXmODBge1lQ2DWCK5x6?=
 =?iso-8859-1?Q?3jisN+JAhA4Jn8hflcievY0IrLFB0ESGcWraJwN2Tuj+/q1uiyL/vTya1N?=
 =?iso-8859-1?Q?YtVu014Klu1rIingqyCzq98bIKpKNEkh47WSw9zakxE6DSzFfYsm3PCggC?=
 =?iso-8859-1?Q?+Ncd/PYQA7cmNwJuzV1yv2bPj2RUH4qlHbYwOrHMuSHfojV84WAAmUXfUG?=
 =?iso-8859-1?Q?8yQGQd070pCxk+MBwm23WryaMb49StcpqcwmHSUWZiU0NFnuPqLxX2If0K?=
 =?iso-8859-1?Q?9MRyyuIYVCf/Y96vxbpxSLvCX/v8QzluvwegQg11YAMqBBHjcbqhNqe+O1?=
 =?iso-8859-1?Q?iMLJf0wq/TEHJhO4wSIE5PuRRKNopvLkEcAaw4E56++xg5GpXM/K/GRhFr?=
 =?iso-8859-1?Q?LsHsyQ3wmRhw9f5ncOiSo/wkKOyWmbW6uz3Epu57uUdIj8CfeScv98LCPw?=
 =?iso-8859-1?Q?JOtV2hMA4QWbV2UobRT4P53be4qdFlstVbDiOqNZhs0Cwi6B3KB7mRwTX/?=
 =?iso-8859-1?Q?GFEKRn/rpwE+EnG0cavyBwwPgYSmPNZlwBzZ/LNkpJkVXbAn7rgJmapwY3?=
 =?iso-8859-1?Q?5oO2UzZJ4SuTAPKjTY9/sIeHM7/W44+cyrA2DReHmaM0AgS9Ucokd7Jd3z?=
 =?iso-8859-1?Q?WE/6rmwsHIFvfdHNSediuK3NqxKJXm1VHW5SXBZg8CeD1gjtPNkYfrp+mI?=
 =?iso-8859-1?Q?ZhCqV0pwgGFrRtnWS2dQP+XczRLvi3UiF81zJn7bFqyTP3Zk6S5G/lgzFd?=
 =?iso-8859-1?Q?i/iaTI4fILx/DH0Pn3RduO3wVdCAw+dycEU3V0v4SKpzx/nBfhL8nTS0BD?=
 =?iso-8859-1?Q?MtAY86LbDAm42z7Xam8Has2ipSBeGu79I6usb9bDKHFPzVwOMbmtNwH62M?=
 =?iso-8859-1?Q?6o1+YrDKZ/d0T9EiJBxxcvwo6+fIV3EfZYdMvUwhEj4otROWBSahJMhX3Z?=
 =?iso-8859-1?Q?M28XkSBgJHFCT4A3zV8w+0npGLOs5Lw+qRxzdOoTKCMPqybpxnDiLR5ef+?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?t7Jt5yKvTVVDJqeM/6YL/7TPz6JmH6lMAu6Rd5g0A+OiApFYqDHspYqTJG?=
 =?iso-8859-1?Q?m/LQwiCTilh4/YvSEH53iVUR8dmChfZmzsKYxpVR/8HoJEggAatKi15MU2?=
 =?iso-8859-1?Q?CterQcrte6ldGzm+mhTUg4NDk4cu38j3gZRVYHl4VSkFEw3m2IGciVjEKC?=
 =?iso-8859-1?Q?pnxnQvDBJ1wk4KD/hsE7S0Y8hyMGPjvB8ksKshrbEnH3M5LVB9aEndWbWr?=
 =?iso-8859-1?Q?shuWNbvWNMzKNyLF9hcP8u4HBFq8X6V67J7Gts7RRLVy2ocKWQ+wW4vcAn?=
 =?iso-8859-1?Q?VS6wy3c4DWoGCxNhtETfHjZaTnnTA64lhtt3Yn4Pg/5DRCZpHRMqLoOHHo?=
 =?iso-8859-1?Q?cUULgXjpDh0I2TTlkrYiWfYm3dYkujr7knxnubc6d1vzs02QWqVuhNZ2PL?=
 =?iso-8859-1?Q?Hoj9NU0Yr78KqU8vsDaFgOFUPu3yIyR8qOa0SbEXCbCdg9jMQWKTdKUiNj?=
 =?iso-8859-1?Q?zXPMSXQvyru2rxpagQKqlIRTGaittL/tb++mmO5ewQQ8Yhl4NhzoK+9vLg?=
 =?iso-8859-1?Q?QA53kRseXJEkISILng8f19tZNwCNIPNZ4k3rE91n363pE44GMs/pT5JBaz?=
 =?iso-8859-1?Q?Hs6bvfGXgoXwRsGJJ8x/lQAwQIgUyi8boGses2QkYNwfNjrePZaL0jLtbv?=
 =?iso-8859-1?Q?15OeV6WW5lr36e4z0eFFTvjBRZp8NmF4yU9+FKohRWykGwRztQzgPZ5RWX?=
 =?iso-8859-1?Q?r3J6Me3fh4XBElx+Qh7dIaBXG0rnsnVdfwQqn6VZDu5roWXNnTnCm0K1Rk?=
 =?iso-8859-1?Q?tqqXpkzT8Y5c7vrUIjmlGEFDXuS4O8Lq96VlGtX3qGVmhNLQGznpvLZttk?=
 =?iso-8859-1?Q?0zjvbN4TV3FaRNN6vyZlZlwn6xuiHGfoyGwY6xdaINKG4pG+CAzMkGu8NY?=
 =?iso-8859-1?Q?KnWVuX+Ge8k4CpxMMhk4THsV24qFD5FZsVlwzTYfYVS6Qt3ZlPMW+eD/eP?=
 =?iso-8859-1?Q?ARgvpMcKVVJ0/UZyJ/GrRGOOHkKB2vAEFyCN8be+iRnohXeyrS0iqmQBfX?=
 =?iso-8859-1?Q?NJPW7NNY3uw3NLc2Ioe1bA7VlebXJYJHfRhe7nFsbKnPCB5Nsdb5MGiQDm?=
 =?iso-8859-1?Q?RVtetI+tYBH1i2cl9NzBddtYJILCWqUopH145OiOWOOCTJp43Kszxb2qOB?=
 =?iso-8859-1?Q?NyREyOEV5bXzWQBdFtt9ibFXFvgZkm17Ht6DhPHZ4ommjXAPiEBc9eLD4v?=
 =?iso-8859-1?Q?BpqtGHT/d/ejFyRdg+3awi4fRZSXlcN7iEcwCnGIa06NE7Intl5vNDxaa2?=
 =?iso-8859-1?Q?8nmMdLnppH3C3BGJj4hFYndIYckzkLd0Dmlj2HQxHzQw1QNfv9/JUlACA6?=
 =?iso-8859-1?Q?jEZUg6pdBslAjFKSY5mCe0rd57mXT5X2fV1gm0Bd69dOLlD+CXJ/iy3YSQ?=
 =?iso-8859-1?Q?nZXD2wtgXWc59pIrS1vdbmiHiuS1nAT6Zj9n8IGoaRC9hVLdQg0VY98PA6?=
 =?iso-8859-1?Q?f3uFKkSfTYZw4m6jza4Uzm6IYuxG3/evbKMvXiaWj6lVuXxtZGfFUQxehB?=
 =?iso-8859-1?Q?ZbVZXKgec+PWkp77Fo//iTSNvQdPuTQx0wp0h1cVE40iHxwqzwelejRtva?=
 =?iso-8859-1?Q?70j0/I99DvGh2/LXnru0i1GZo79x7Clx7FpPbyUq7g1w143SzT4Po4D1YQ?=
 =?iso-8859-1?Q?w8BtC7+NSo4QA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11cbf44-7e45-4162-8104-08ddb3af8b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 06:14:29.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiODhqEIy2f5YrWqvEYcP4uCjUHthk1D8sLyEMTJ65jxwoqCZTWpgK1nCHuSJceKK6TdrA6pX0LzV3Z9Ir7m+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648

[Public]

> -----Original Message-----
> From: Folker Schwesinger <dev@folker-schwesinger.de>
> Sent: Thursday, June 19, 2025 12:03 PM
> To: dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>; Simek, Michal <michal.simek@amd.com>;
> Jernej Skrabec <jernej.skrabec@gmail.com>; Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@baylibre.com>; Marek Vasut <marex@denx.de>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>
> Subject: [PATCH v2] dmaengine: xilinx_dma: Support descriptor setup from =
dma_vecs
>
> Caution: This message originated from an External Source. Use proper caut=
ion when
> opening attachments, clicking links, or responding.
>
>
> The DMAEngine provides an interface for obtaining DMA transaction descrip=
tors from
> an array of scatter gather buffers represented by struct dma_vec. This in=
terface is
> used in the DMABUF API of the IIO framework [1].
> To enable DMABUF support through the IIO framework for the Xilinx DMA, im=
plement
> callback .device_prep_peripheral_dma_vec() of struct dma_device in the dr=
iver.
>
> [1]: https://elixir.bootlin.com/linux/v6.16-rc1/source/drivers/iio/buffer=
/industrialio-buffer-
> dmaengine.c#L104
>
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>

Implementation same as xilinx_dma_prep_slave_sg(), looks fine to me.

Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
>
> ---
> Changes in v2:
> - Improve commit message to include reasoning behind the change.
> - Rebase onto v6.16-rc1.
> - Link to v1:
> https://lore.kernel.org/dmaengine/D8TV2MP99NTE.1842MMA04VB9N@folker-
> schwesinger.de/
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 94 +++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c index
> a34d8f0ceed8..fabff602065f 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2172,6 +2172,99 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan,
> dma_addr_t dma_dst,
>         return NULL;
>  }
>
> +/**
> + * xilinx_dma_prep_peripheral_dma_vec - prepare descriptors for a DMA_SL=
AVE
> + *     transaction from DMA vectors
> + * @dchan: DMA channel
> + * @vecs: Array of DMA vectors that should be transferred
> + * @nb: number of entries in @vecs
> + * @direction: DMA direction
> + * @flags: transfer ack flags
> + *
> + * Return: Async transaction descriptor on success and NULL on failure
> +*/ static struct dma_async_tx_descriptor
> +*xilinx_dma_prep_peripheral_dma_vec(
> +       struct dma_chan *dchan, const struct dma_vec *vecs, size_t nb,
> +       enum dma_transfer_direction direction, unsigned long flags) {
> +       struct xilinx_dma_chan *chan =3D to_xilinx_chan(dchan);
> +       struct xilinx_dma_tx_descriptor *desc;
> +       struct xilinx_axidma_tx_segment *segment, *head, *prev =3D NULL;
> +       size_t copy;
> +       size_t sg_used;
> +       unsigned int i;
> +
> +       if (!is_slave_direction(direction) || direction !=3D chan->direct=
ion)
> +               return NULL;
> +
> +       desc =3D xilinx_dma_alloc_tx_descriptor(chan);
> +       if (!desc)
> +               return NULL;
> +
> +       dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> +       desc->async_tx.tx_submit =3D xilinx_dma_tx_submit;
> +
> +       /* Build transactions using information from DMA vectors */
> +       for (i =3D 0; i < nb; i++) {
> +               sg_used =3D 0;
> +
> +               /* Loop until the entire dma_vec entry is used */
> +               while (sg_used < vecs[i].len) {
> +                       struct xilinx_axidma_desc_hw *hw;
> +
> +                       /* Get a free segment */
> +                       segment =3D xilinx_axidma_alloc_tx_segment(chan);
> +                       if (!segment)
> +                               goto error;
> +
> +                       /*
> +                        * Calculate the maximum number of bytes to trans=
fer,
> +                        * making sure it is less than the hw limit
> +                        */
> +                       copy =3D xilinx_dma_calc_copysize(chan, vecs[i].l=
en,
> +                                       sg_used);
> +                       hw =3D &segment->hw;
> +
> +                       /* Fill in the descriptor */
> +                       xilinx_axidma_buf(chan, hw, vecs[i].addr, sg_used=
, 0);
> +                       hw->control =3D copy;
> +
> +                       if (prev)
> +                               prev->hw.next_desc =3D segment->phys;
> +
> +                       prev =3D segment;
> +                       sg_used +=3D copy;
> +
> +                       /*
> +                        * Insert the segment into the descriptor segment=
s
> +                        * list.
> +                        */
> +                       list_add_tail(&segment->node, &desc->segments);
> +               }
> +       }
> +
> +       head =3D list_first_entry(&desc->segments, struct xilinx_axidma_t=
x_segment,
> node);
> +       desc->async_tx.phys =3D head->phys;
> +
> +       /* For the last DMA_MEM_TO_DEV transfer, set EOP */
> +       if (chan->direction =3D=3D DMA_MEM_TO_DEV) {
> +               segment->hw.control |=3D XILINX_DMA_BD_SOP;
> +               segment =3D list_last_entry(&desc->segments,
> +                                         struct xilinx_axidma_tx_segment=
,
> +                                         node);
> +               segment->hw.control |=3D XILINX_DMA_BD_EOP;
> +       }
> +
> +       if (chan->xdev->has_axistream_connected)
> +               desc->async_tx.metadata_ops =3D &xilinx_dma_metadata_ops;
> +
> +       return &desc->async_tx;
> +
> +error:
> +       xilinx_dma_free_tx_descriptor(chan, desc);
> +       return NULL;
> +}
> +
>  /**
>   * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transa=
ction
>   * @dchan: DMA channel
> @@ -3180,6 +3273,7 @@ static int xilinx_dma_probe(struct platform_device =
*pdev)
>         xdev->common.device_config =3D xilinx_dma_device_config;
>         if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
>                 dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
> +               xdev->common.device_prep_peripheral_dma_vec =3D
> + xilinx_dma_prep_peripheral_dma_vec;
>                 xdev->common.device_prep_slave_sg =3D xilinx_dma_prep_sla=
ve_sg;
>                 xdev->common.device_prep_dma_cyclic =3D
>                                           xilinx_dma_prep_dma_cyclic;
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> --
> 2.49.0


