Return-Path: <dmaengine+bounces-7641-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBADCC041F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 00:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B3DC300C357
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 23:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132332ED4A;
	Mon, 15 Dec 2025 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="D6Wc2J9C"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DE32ED44;
	Mon, 15 Dec 2025 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842810; cv=fail; b=NVHWddgwuGlY6UlSj+LxgMHRa6hI8Pny+yQtcZp0xsL+rr9Yab/2tvHzwkKXDL2CP5/ZlHOVvX64jTuYTqYtt2fIpNNveuMG37g1Lp7JnBcxYl09HnsyIzIYn8vhK5RErrIjc05OXLCu9D1iPu8RPr16CNWFhFeGzAWxmYKuIpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842810; c=relaxed/simple;
	bh=osjWMXae2NKvmyhBtQYEIbrv2aC7DCjnuMosQHb33lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TAokA7yancgN41eMBpwQ9DZ89Pu44KiY+OhaXezb7JImVHoNEg1AjLjs/CnOTdP9KVcdCsLyQsovdGXL1HEALi+Q2PXtFsvVECBm45cC1XwY8KBeJh6FRVpUAJKP3icq+TC8HjWKtkChTyB+idi2Vd9+8hGG+ti3Ofhxpd/ID4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=D6Wc2J9C; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbllkFiT2A9Z5QYLxE95ZZL3ZyN2vUCJ44Pxc2O+Fcq9CfVJsd7eSxcyf5mS0kvOKE6yQg5P9qiborTQVj4yu9Iv3xeK1kqHHxVcSVHTFV92w6F/hopxrTiVH35FLxsmMvnnfgFyLLsakQAqGPx09+Z5f6TktGDBTbQkQe67ANqc52RWk/wHO/V8JemyLAgVk+alN1KKBROBRMqZRXmcX2sKWNZhDhaNTqCRab2apzSAaxkXntbCwfHA8SWewfZOkrP18Lw4UwajcLN+p33cTZigCTALlFtc0cgEnvHq+T/YJytw5Z6kzoXPtQGNH5LNtCh6d2pQ6rZkDfu5B8whYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osjWMXae2NKvmyhBtQYEIbrv2aC7DCjnuMosQHb33lc=;
 b=Ym7ePNf/jfPA3RCs/EJ2WrelMPH/1xhASyy6NYOCzGrm46MLNZOMYDZd7ts7fPsUQh+WauLtYphNogo0vMFVlZW1XU6xFWZsnx4OVLvmipfzVl/H55X1xL2Wc6jryixUwZbi90zMDRwGoWjttQfVv4OTzBxfMVEXEjSeTLOuv1UDTzgCPNzhHtxFmYRb3o8nfm2mzqTdNgIJXnHaomviE5CUANgrB2JijUCepXnf+MDMyBR/xrxbTZC7iVnVssxm+0rnMEQmTd9u2hzO80qX2Uawppau1T7P1pUAPUjLw2d3B2fb0hc5602VTg0fBuLwErV9RucaEoC1+xq1xPmIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osjWMXae2NKvmyhBtQYEIbrv2aC7DCjnuMosQHb33lc=;
 b=D6Wc2J9C3x6qlkl978ck74+TpCCobzBua2XMESCpYynoV2klaPETvmS4TNLpOV7RFRu8mwTC9nDnnYNAA+h4v2j0ms8oTIQupy+KlDxR89XjizfZwWs5UZHUE9uwM2ERAdrDebwlUMTYA4HIKbzmoRprCukJnKHwpepbZeCeCiNxeLOyE8qshF3i5+9o0sceJx+PiX08yPky/CZ9FSP37AbHo2EjeIJiSK+GqZ3jOeRN0vbT8j03ExQ1pS7amTTnYX5pOOzwJ577XTyBHNoKbPBQF6wQs4cSL2hLVU+F9CdZDH6Nt7V9Jzj2uVx0WBkiZSA010siRBg0+QTcnD6yKg==
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA3PR03MB8326.namprd03.prod.outlook.com (2603:10b6:806:462::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 23:53:26 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 23:53:26 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Rob Herring <robh@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Eugeniy Paltsev
	<Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
Thread-Topic: [PATCH v3 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
Thread-Index: AQHcalhVEwmMZRtFIkGO/9LTwzjtj7UclaMAgAACEoCAAJU2AIAA0mCAgAVoBYA=
Date: Mon, 15 Dec 2025 23:53:26 +0000
Message-ID: <47bd1689-292f-4d2d-a668-6da81db761e5@altera.com>
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
 <646113c742278626c8796d8553cdb251a4daf737.1765425415.git.khairul.anuar.romli@altera.com>
 <20251211154524.GA1464056-robh@kernel.org>
 <CAL_JsqKPVdUzytrVKs5q5JfPnxLdz-UdN5K-cJUVQ_uWM5azLA@mail.gmail.com>
 <b4e36cd5-959b-4758-8c52-6dad7e6f17f0@altera.com>
 <CAL_JsqL5yLyQ2_MEGorETtqz_EEZDRy_b+9PtBcV5ZVFG25qyg@mail.gmail.com>
In-Reply-To:
 <CAL_JsqL5yLyQ2_MEGorETtqz_EEZDRy_b+9PtBcV5ZVFG25qyg@mail.gmail.com>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR03MB8447:EE_|SA3PR03MB8326:EE_
x-ms-office365-filtering-correlation-id: 35bed696-903f-4ca3-974b-08de3c3523d8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0kzd3U1bmlGU3lRZS9Qaml6ZjlIU3I4L2cxWDZqWFhxUnRvcVdqVW1JSE8r?=
 =?utf-8?B?b3FVRWcrcUJBS1JZYjQrcWlLTGIxQUpKRm50VVlLNW5SU1JzeXNjWXVzWlMw?=
 =?utf-8?B?NzRBQjJoVTd2RjdUNmt6ZjZYTHpNY0Y1eFI0Z2VCc0hBWE4yRlQzbWd1ajZP?=
 =?utf-8?B?R0huZkRhUEsvUjhXZUJXR1hEbUNWZTNNYnNwWmR3dVV4Sm1hQTBsem9PVUJr?=
 =?utf-8?B?NHlnRmNnSno4L3duV09FdUJOTGtFV3FYeFN3ZVBDVjVvMW5Bb3NrQm5pZ1k0?=
 =?utf-8?B?NFJmUWkyWTEyckF1QkhIZmVtNWVXSVdNTGxLZ0NscTdPWEZOQnpOaytiR3pJ?=
 =?utf-8?B?d2Nlb3VDWTA1bEI0ZC9STXRiNlZGNytmVm0vY1g1N3RHRTArK2FLRDRTcGxK?=
 =?utf-8?B?bzd6SXBwVWw4VnlKTE1GdzZ0L3JHcFVTZkloVVJGcHpTRXkzK29GYUc3cFR1?=
 =?utf-8?B?NThyWTI5eXVQaWtTRXpwWkl4bDJPWHhVY1hYZWVOZ0w2TjhZTERnSUd5V1Jy?=
 =?utf-8?B?bGg2RWJoR1IrcXN5R0FTMFpaRGhXT01mNThBb3MyVnNIRXN5VFp2WXYvRzY4?=
 =?utf-8?B?alYzcUxhcW93NUk2ejVmdlJZbXNOdytFbGdMY2lwTGV0eDViZE9uQmxybkMv?=
 =?utf-8?B?RFUyKzFYdnM2OXplNXFFbVFuQUk1TVRnZ1VUV1puc3RaWUN0dFhld2ZpZEVT?=
 =?utf-8?B?Mzk1c2s5THpZMndZS0xPcXY1M0dDR2ZkTHQ1WjJ6cDVncmNoQ0d1ZnZPaUY5?=
 =?utf-8?B?K2RUektRWDJETENOTzM1cUNmUHJQWnRmMy91QkpRSXVtNzVsR3RIaElrQTNV?=
 =?utf-8?B?UWJiRGNjdFYzcHFXNEFmQWI5QWdWdllaMHV2cUlkN1BnbzVjd09UUk9WS2ZW?=
 =?utf-8?B?S0VqSithN0RMcG1iUklZNGNOOGg1L1FUN2htdE9nd09JYWoxVzJDS3ZzeDcw?=
 =?utf-8?B?SVdyNFppNmZrRVZYWUVtVWNTTFl2MERZdDVxM0FkbkVGcFlUNjZWbVhEaEsv?=
 =?utf-8?B?K2NqRGFDK1MvaSs5elFpbExDbGUrYzlXSWo4elprMDhRMTgwQUJSUlY1cjYx?=
 =?utf-8?B?MGtzL0VUTXZmUDdEVi9CRHlUbTV0TjRUdjZSYUZDNmFyR2pjTnIxZUw0MWJ0?=
 =?utf-8?B?WXRqVmtxV3FoTmRaSEIyRldBSnNLT0ZkalBpbmRHcm1GRmx6d0hBZ3BTWTNm?=
 =?utf-8?B?K1Vnb1hoSmlzOFF3K2lUeFNTWjFaNjdXcjJUQkM1TWovNVhzZHlTSEltajRP?=
 =?utf-8?B?K25nL0N5d2VPN2o5VVB2T3hzbEhXSTNpa1YwN0pacU81ZURraFlndlhXTTRB?=
 =?utf-8?B?NHl3QXRqcW1qb1N4c3l1N3ByVVRNNmZXU2xRN0pBaVlBZWtjMlB0c3BYUzlX?=
 =?utf-8?B?QWtqL3pUT0pJeWFmUkJxV2kwcU1ieUVuTzNUczhnUVI2WnYwaUtlWUVGa1B0?=
 =?utf-8?B?ellYUHVEWHcrYkk2L010RGZ5WEJUNlJ4dGVLMklZV0J3K3lSajl5RnZIQnYw?=
 =?utf-8?B?cWRjdGJTUXVSY2NnVEJLbmY0emVBN0RKM01GQ3UxOUpUdXRJSk1zWndCb0t1?=
 =?utf-8?B?VFUzZXcxLzYydzF4anVTQ25ZZUJzZDdWNkFveW1ROTZHYXV3SFVkM21uZE82?=
 =?utf-8?B?bDk5Y3I2eGlxdldQYUw2dlJIODY2dVhMK3Q3K2dWblB2YW1Vd3Ezc3h6S3p2?=
 =?utf-8?B?SHZLU0NGVHIxa3U4bzUvQ3ZBd016MWJhdy9JQXZRb3ZBTEg2QVZJMlFsaURP?=
 =?utf-8?B?dEREckpXeU10NVVnQ3lRUmthODRJZGVYM3NSVW9SUWhPSWt4ZEFhaXZlMUpH?=
 =?utf-8?B?blh3NjV5cGhZcFVkZ2RDVE9hZHFtbmRxNGp0aXpRamhiV1kwOGpnNGI3eVli?=
 =?utf-8?B?Q24rTGtkZHhKNWRKcGI5dWxBQnRUVTRxakJ1WGZoNUUwc2VFcEF3cFlkN2Z4?=
 =?utf-8?B?TzJwb0ZxVk5WUDUvSnNuNGo4ems5Ykw3ZzBFSE1mTUFOOFlCemtrK2piR1Zo?=
 =?utf-8?B?RE05b3VMNy9NWXpFSjBBTXdEemNaMXB6Nmt4b3dKZjdlVzRVRnBoQWJuZy83?=
 =?utf-8?Q?lcqlBu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWlFKzZ1RDhneWV2d2NjaUNNbWNDcWpqdWZ3N1VHN2JUNmx1ZEJ6TlhMWURJ?=
 =?utf-8?B?Z2tBdW5OK01Ya082Y2dCaVMxS3JZSHFldXdjQUVJenQvcysxRVdxeWlYNG9I?=
 =?utf-8?B?LzZtcFlQazBRS00vV3E4bncrYTNJMjVxOFViL3RVVjlUakhPWUxkSVJvQVF1?=
 =?utf-8?B?Q3YwLy82b0pJTEgyLzBXV1REemFKZmJmbHZmQVFDalJhNkxQY0dnL0hteVZR?=
 =?utf-8?B?alovWTMvbGtZbnJuQ1JnNW1qWFBTVnk2ZVc2Y2p1bzB0cDhBSFN4ZGoxekpU?=
 =?utf-8?B?STMwTmZnT2NmaVJQN3d3b3VLVExOKzNBdVp3ZXZvVERnd1NmenhPaWp4N1JD?=
 =?utf-8?B?QmxocVAvcXo0bzJYY1ovNmNsMGFBS0ZBVFduQ3IxdHdaT0ZTdnhFNDR6SEox?=
 =?utf-8?B?VTM0SURyKzNUVGRzSjRoN2JGYndCR1Z0eVZ4b1N3WFJTWmdEWlR2b0pMWXZ3?=
 =?utf-8?B?dklQaDVxTWNOdlcwU3c4alduc281ajk4aEhZcmppVXMzWHhHaTdkSzJlWHRn?=
 =?utf-8?B?OUFSMldnY0g4TlNMK1BZMC9SZWtsSnBZSlErUmJ3SUVaZW03ait5RlV5T2Nh?=
 =?utf-8?B?TURydysvalBtbGZZa2dSOC9LQmx4YUVYZUVuanRwcjU2bjVnd3RseHlrWFpn?=
 =?utf-8?B?Qk8rckRwNTQxd28xaDIvM3REeFBOazVGeXdteW9DTmhmZWtVTzdkckx2bVFa?=
 =?utf-8?B?REd2cTBNREgwRWhwOFpoclFsaXY1ZmlGaEhRaHUzT2QyNitaLzJ1dmFwNTFj?=
 =?utf-8?B?WFJlUlpVa0haTHExdkJJZk9OL1poak9JR2lxVktReWljdUNXSnMrK1k3dXRu?=
 =?utf-8?B?SEJGRkpoYnlrYWVHYms1MjRGSFFINGtkcUV4ZGZQbytJa3B6c0Z5U1JNS2VH?=
 =?utf-8?B?UjFTaHRoUWVsOE1DajBDR2hYWmczMHk5S3h6YithNTRRTkVPWnloc1ZuRzUx?=
 =?utf-8?B?Y2FXUjArWkp6eUZaQVFodXZ0Q1A0S1pSbFlKU3d0OUdjckI1d0NLSVBJZnl6?=
 =?utf-8?B?T2E3aUJacEU5eEpNQVZ2KzJUSEhwYTNJZHZmdzI3M1VSOHhRS01KR2FlRHRE?=
 =?utf-8?B?L2gxZ0JRRDlrMzY0QnZVaVc0ZlJHYjNra0dRNUdjRndFMkNraVc2cFVQTXhy?=
 =?utf-8?B?YXVrSGFRcndkRWtEakNBOHQ5S0VpZSs5TlVxeGRReml4SDhac0piN081YWUr?=
 =?utf-8?B?dVpvZndiaWVzelZOUzJDV05iZE5IZ2d6UTN4R25tS0dhSDg1K3V2SFZWL2hv?=
 =?utf-8?B?alcrK05DWU83eC94WnNLOU5IU2hPU28zZkMzSStqWXYwVzh6dER4Z2VPUzB6?=
 =?utf-8?B?SDZacE5BbG5KdFNMN0sySm0zK1lvdHRXdzhPcVBNNWozUFFjT3FwM1hpQVZX?=
 =?utf-8?B?V0VjMDBqeG9VNXYyVms2WlU1azJ2RVpuN3Q4bmwyRDQvdDQ1N2xrUkcxVHV5?=
 =?utf-8?B?ZjgzZkNCZytNN1I3VDRyaVlYVzJ0SkJhSE5yWUNXekttWS83dTU4dFJRdnAy?=
 =?utf-8?B?cTc1cVBpV0x1ZDRpenVjV0Q5bHhybzkvcHY5VXhDeUJ2emQyZno1MUFPVUVX?=
 =?utf-8?B?OTV4NXFFRGROWHJwRnFXT0lXU2hhd2RwUGY2RXc5QzdUOXd0dFY5eTFlQko1?=
 =?utf-8?B?ZkljeE1DRWVQZHQ2RVlwRGtMV1hlK1hiZ0tLaTBYS1o0cHNaT2oydndDZ3dp?=
 =?utf-8?B?OEt6TlNrTEFrMjFDMy9renc2ZDd3dmN1NnJqVFZPZUhWcitzcWpjRzhCeVI3?=
 =?utf-8?B?bEp1U3IwOERPSjMvN1RGbFh6bUQ3TG1Nc0ljYkxPK3dqbEcrWXZDejNQTWNx?=
 =?utf-8?B?ME0xaWpXTkVhZXdsZFZCRG9CMk9nSkpLK0s4c3psdUdLN2JBek56d0RNUmFj?=
 =?utf-8?B?REdsWkphVktrNlhFZUhMWEpnRnY0NnlCdlFhMWx3OThsaFRpR2d4Y2x1K1pF?=
 =?utf-8?B?cDJYRHN3ZU9kWThXaW10OXhlZ01ya2xEMEFBR2JGQmR4bUxJKzg0YWtTa3hy?=
 =?utf-8?B?ZHorMEtJSGgzRUlnS3psUitBL3BJMmhkQVpCQ0tRU1pvRkR4b3dtNjRpTXli?=
 =?utf-8?B?QVRMOGZpY3FiSnhxdkFUWVBpVFBvcklEc2hmRStzY3VJK0ZEdWdQaGh4S3Ra?=
 =?utf-8?B?YXRwY0d6dGJBRU1OL3JEdG5VVkh0MnVWN3NzWEFVeVd3bEZncTJ6alBWVUtT?=
 =?utf-8?B?Z29FVklKS1I3dVY0VzRKT1JXbDZ6cFUwQWNwMFFPaHI2WkhlNzZsSkZlY2l3?=
 =?utf-8?B?TnhqY3FQVDZXa0JSVDJnL1NOWUxqMU52NzlpWXdDeFlDcnBZY0IybHpQMjRE?=
 =?utf-8?B?eE1vOTdZL2FZZ1dQNW9zMHZ5VWtkelY5Rk1SWUh2VlZlZ2lrQm5qTHdPY1NC?=
 =?utf-8?Q?aGO+611aJV0hd0hQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D70ED465D297F1458DA944150366AB7C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bed696-903f-4ca3-974b-08de3c3523d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 23:53:26.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQT2gsNsVldmI3W/SJbcFvJrGVnZ1uUjf78enruKPmiiLoxFoQd9D+q5Uv0P3LQlhNrJ/bMFhEtwHfc95eJSpQv3QRjV+xQuHyE/ds4+OE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8326

T24gMTIvMTIvMjAyNSA5OjE5IHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gVGh1LCBEZWMg
MTEsIDIwMjUgYXQgNjo0NuKAr1BNIFJvbWxpLCBLaGFpcnVsIEFudWFyDQo+IDxraGFpcnVsLmFu
dWFyLnJvbWxpQGFsdGVyYS5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDExLzEyLzIwMjUgMTE6NTIg
cG0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+IE9uIFRodSwgRGVjIDExLCAyMDI1IGF0IDk6NDXi
gK9BTSBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4NCj4+Pj4gT24g
VGh1LCBEZWMgMTEsIDIwMjUgYXQgMTI6NDA6MzhQTSArMDgwMCwgS2hhaXJ1bCBBbnVhciBSb21s
aSB3cm90ZToNCj4+Pj4+IEFkZCBkZXZpY2UgdHJlZSBjb21wYXRpYmxlIHN0cmluZyBzdXBwb3J0
IGZvciB0aGUgQWx0ZXJhIEFnaWxleDUgQVhJIERNQQ0KPj4+Pj4gY29udHJvbGxlci4NCj4+Pj4+
DQo+Pj4+PiBJbnRyb2R1Y2VzIGxvZ2ljIHRvIHBhcnNlIHRoZSAiZG1hLXJhbmdlcyIgcHJvcGVy
dHkgYW5kIGNhbGN1bGF0ZSB0aGUNCj4+Pj4+IGFjdHVhbCBudW1iZXIgb2YgYWRkcmVzc2FibGUg
Yml0cyAoYnVzIHdpZHRoKSBmb3IgdGhlIERNQSBlbmdpbmUuIFRoaXMNCj4+Pj4+IGNhbGN1bGF0
ZWQgdmFsdWUgaXMgdGhlbiB1c2VkIHRvIHNldCB0aGUgY29oZXJlbnQgbWFzayB2aWENCj4+Pj4+
ICdkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCknLCBhbGxvd2luZyB0aGUgZHJpdmVyIHRvIGNv
cnJlY3RseSBoYW5kbGUNCj4+Pj4+IGRldmljZXMgd2l0aCBidXMgd2lkdGhzIGxlc3MgdGhhbiA2
NCBiaXRzLiBUaGUgYWRkcmVzc2FibGUgYml0cyBkZWZhdWx0IHRvDQo+Pj4+PiA2NCBpZiAnZG1h
LXJhbmdlcycgaXMgbm90IHNwZWNpZmllZCBvciBjYW5ub3QgYmUgcGFyc2VkLg0KPj4+Pj4NCj4+
Pj4+IEludHJvZHVjZSAnYWRkcmVzc2FibGVfYml0cycgdG8gJ3N0cnVjdCBheGlfZG1hX2NoaXAn
IHRvIHN0b3JlIHRoaXMgdmFsdWUuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1
bCBBbnVhciBSb21saSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4+Pj4gLS0t
DQo+Pj4+PiBDaGFuZ2VzIGluIHYzOg0KPj4+Pj4gICAgICAgICAtIFJlZmFjdG9yIHRoZSBjb2Rl
IHRvIGFsaWduIHdpdGggZG1hIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUgbW92ZQ0KPj4+Pj4gICAg
ICAgICAgIHRvIDEgbGV2ZWwgZG93bi4NCj4+Pj4+IENoYW5nZXMgaW4gdjI6DQo+Pj4+PiAgICAg
ICAgIC0gQWRkIGRyaXZlciBpbXBsZW1lbnRhdGlvbiB0byBzZXQgdGhlIERNQSBCSVQgTUFTVCB0
byA0MCBiYXNlZCBvbg0KPj4+Pj4gICAgICAgICAgIGRtYS1yYW5nZXMgZGVmaW5lZCBpbiBEVC4N
Cj4+Pj4+ICAgICAgICAgLSBBZGQgZ2x1ZSBmb3IgZHJpdmVyIGFuZCBEVC4NCj4+Pj4+IC0tLQ0K
Pj4+Pj4gICAgLi4uL2RtYS9kdy1heGktZG1hYy9kdy1heGktZG1hYy1wbGF0Zm9ybS5jICAgIHwg
NjkgKysrKysrKysrKysrKysrKysrLQ0KPj4+Pj4gICAgZHJpdmVycy9kbWEvZHctYXhpLWRtYWMv
ZHctYXhpLWRtYWMuaCAgICAgICAgIHwgIDEgKw0KPj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA2
OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3JtLmMgYi9kcml2ZXJz
L2RtYS9kdy1heGktZG1hYy9kdy1heGktZG1hYy1wbGF0Zm9ybS5jDQo+Pj4+PiBpbmRleCBiMjM1
MzY2NDVmZjcuLjk2YjBhMDg0MmZmNSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvZG1hL2R3
LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3JtLmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZG1h
L2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3JtLmMNCj4+Pj4+IEBAIC0yNzEsNyArMjcx
LDkgQEAgc3RhdGljIHZvaWQgYXhpX2RtYV9od19pbml0KHN0cnVjdCBheGlfZG1hX2NoaXAgKmNo
aXApDQo+Pj4+PiAgICAgICAgICAgICAgICAgYXhpX2NoYW5faXJxX2Rpc2FibGUoJmNoaXAtPmR3
LT5jaGFuW2ldLCBEV0FYSURNQUNfSVJRX0FMTCk7DQo+Pj4+PiAgICAgICAgICAgICAgICAgYXhp
X2NoYW5fZGlzYWJsZSgmY2hpcC0+ZHctPmNoYW5baV0pOw0KPj4+Pj4gICAgICAgICB9DQo+Pj4+
PiAtICAgICByZXQgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGNoaXAtPmRldiwgRE1BX0JJ
VF9NQVNLKDY0KSk7DQo+Pj4+PiArDQo+Pj4+PiArICAgICBkZXZfZGJnKGNoaXAtPmRldiwgIkFk
cmVzc2FibGUgYnVzIHdpZHRoOiAldVxuIiwgY2hpcC0+YWRkcmVzc2FibGVfYml0cyk7DQo+Pj4+
PiArICAgICByZXQgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGNoaXAtPmRldiwgRE1BX0JJ
VF9NQVNLKGNoaXAtPmFkZHJlc3NhYmxlX2JpdHMpKTsNCj4+Pj4+ICAgICAgICAgaWYgKHJldCkN
Cj4+Pj4+ICAgICAgICAgICAgICAgICBkZXZfd2FybihjaGlwLT5kZXYsICJVbmFibGUgdG8gc2V0
IGNvaGVyZW50IG1hc2tcbiIpOw0KPj4+Pj4gICAgfQ0KPj4+Pj4gQEAgLTE0NjEsMTMgKzE0NjMs
MjQgQEAgc3RhdGljIGludCBheGlfcmVxX2lycXMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diwgc3RydWN0IGF4aV9kbWFfY2hpcCAqY2hpcCkNCj4+Pj4+ICAgICAgICAgcmV0dXJuIDA7DQo+
Pj4+PiAgICB9DQo+Pj4+Pg0KPj4+Pj4gKy8qIEZvcndhcmQgZGVjbGFyYXRpb24gKG5vIHNpemUg
cmVxdWlyZWQpICovDQo+Pj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZHdf
ZG1hX29mX2lkX3RhYmxlW107DQo+Pj4+PiArDQo+Pj4+PiAgICBzdGF0aWMgaW50IGR3X3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pj4+PiAgICB7DQo+Pj4+PiAgICAgICAg
IHN0cnVjdCBheGlfZG1hX2NoaXAgKmNoaXA7DQo+Pj4+PiAgICAgICAgIHN0cnVjdCBkd19heGlf
ZG1hICpkdzsNCj4+Pj4+ICAgICAgICAgc3RydWN0IGR3X2F4aV9kbWFfaGNmZyAqaGRhdGE7DQo+
Pj4+PiAgICAgICAgIHN0cnVjdCByZXNldF9jb250cm9sICpyZXNldHM7DQo+Pj4+PiArICAgICBz
dHJ1Y3QgZGV2aWNlX25vZGUgKnBhcmVudDsNCj4+Pj4+ICsgICAgIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgKm1hdGNoOw0KPj4+Pj4gICAgICAgICB1bnNpZ25lZCBpbnQgZmxhZ3M7DQo+Pj4+
PiArICAgICB1bnNpZ25lZCBpbnQgYWRkcmVzc2FibGVfYml0cyA9IDY0Ow0KPj4+Pj4gKyAgICAg
dW5zaWduZWQgaW50IGxlbl9ieXRlczsNCj4+Pj4+ICsgICAgIHVuc2lnbmVkIGludCBudW1fY2Vs
bHM7DQo+Pj4+PiArICAgICBjb25zdCBfX2JlMzIgKnByb3A7DQo+Pj4+PiArICAgICB1NjQgYnVz
X3dpZHRoOw0KPj4+Pj4gKyAgICAgdTMyICpjZWxsczsNCj4+Pj4+ICAgICAgICAgdTMyIGk7DQo+
Pj4+PiAgICAgICAgIGludCByZXQ7DQo+Pj4+Pg0KPj4+Pj4gQEAgLTE0ODMsOSArMTQ5Niw2MSBA
QCBzdGF0aWMgaW50IGR3X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pj4+
PiAgICAgICAgIGlmICghaGRhdGEpDQo+Pj4+PiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9N
RU07DQo+Pj4+Pg0KPj4+Pj4gKyAgICAgbWF0Y2ggPSBvZl9tYXRjaF9ub2RlKGR3X2RtYV9vZl9p
ZF90YWJsZSwgcGRldi0+ZGV2Lm9mX25vZGUpOw0KPj4+Pj4gKyAgICAgaWYgKCFtYXRjaCkgew0K
Pj4+Pj4gKyAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJVbnN1cHBvcnRlZCBBWEkg
RE1BIGRldmljZVxuIik7DQo+Pj4+PiArICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPj4+
Pj4gKyAgICAgfQ0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgcGFyZW50ID0gb2ZfZ2V0X3BhcmVudChw
ZGV2LT5kZXYub2Zfbm9kZSk7DQo+Pj4+PiArICAgICBpZiAocGFyZW50KSB7DQo+Pj4+PiArICAg
ICAgICAgICAgIHByb3AgPSBvZl9nZXRfcHJvcGVydHkocGFyZW50LCAiZG1hLXJhbmdlcyIsICZs
ZW5fYnl0ZXMpOw0KPj4+Pj4gKyAgICAgICAgICAgICBpZiAocHJvcCkgew0KPj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgIG51bV9jZWxscyA9IGxlbl9ieXRlcyAvIHNpemVvZihfX2JlMzIpOw0K
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNlbGxzID0ga2NhbGxvYyhudW1fY2VsbHMsIHNp
emVvZigqY2VsbHMpLCBHRlBfS0VSTkVMKTsNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBp
ZiAoIWNlbGxzKQ0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQo+Pj4+PiArDQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgcmV0ID0gb2ZfcHJv
cGVydHlfcmVhZF91MzIocGFyZW50LCAiI2FkZHJlc3MtY2VsbHMiLCAmaSk7DQo+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAibWlzc2luZyAjYWRkcmVzcy1jZWxscyBwcm9w
ZXJ0eVxuIik7DQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIH0NCj4+Pj4+ICsNCj4+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICByZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihwYXJlbnQsICIjc2l6ZS1j
ZWxscyIsICZpKTsNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+Pj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJtaXNz
aW5nICNzaXplLWNlbGxzIHByb3BlcnR5XG4iKTsNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgfQ0KPj4+
Pj4gKw0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGlmICghb2ZfcHJvcGVydHlfcmVhZF91
MzJfYXJyYXkocGFyZW50LCAiZG1hLXJhbmdlcyIsDQo+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjZWxscywgbnVtX2NlbGxzKSkgew0K
Pj4+Pg0KPj4+PiBXZSBoYXZlIGNvbW1vbiBjb2RlIHRvIHBhcnNlIGRtYS1yYW5nZXMuIFVzZSBp
dCBhbmQgZG9uJ3QgaW1wbGVtZW50IHlvdXINCj4+Pj4gb3duLg0KPj4+DQo+Pj4gQWN0dWFsbHks
IHRoZSBkcml2ZXIgYW5kIERUIGNvcmUgc2hvdWxkIHRha2UgY2FyZSBvZiBhbGwgdGhpcyBmb3Ig
eW91DQo+Pj4gYW5kIHRoZXJlJ3Mgbm90aGluZyB0byBkbyBpbiB0aGUgZHJpdmVyLiBBIGRyaXZl
ciBvbmx5IG5lZWRzIHRvIHNldA0KPj4+IHRoZSBtYXNrIGZvciB0aGUgSVAgaXRzZWxmIGFuZCBv
bmx5IHdoZW4gPjMyIGJpdHMuIFRoZSBjb3JlIHRha2VzIGNhcmUNCj4+PiBvZiBhbnkgYWRkaXRp
b25hbCByZXN0cmljdGlvbnMgaW4gdGhlIGJ1cy4NCj4+Pg0KPj4+IFJvYg0KPj4NCj4+IFRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uIGV4cGxpY2l0bHkgc2V0IHRoZSBtYXNrIHRvIDY0Lg0KPj4N
Cj4+IC0gICAgIHJldCA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoY2hpcC0+ZGV2LCBETUFf
QklUX01BU0soNjQpKTsNCj4+DQo+PiBXaWxsIHRoZSBjb3JlIHJlLXNldCB0aGUgbWFzayBiYXNl
ZCBvbiB0aGUgZG1hLXJhbmdlcyBvbiBEVD8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgaXQgY2hhbmdl
cyB0aGUgbWFzaywgYnV0IHRoZXJlJ3MgYWxzbyBidXMgcmFuZ2VzIHdoaWNoDQo+IGdldCBmYWN0
b3JlZCBpbi4gU2VlIHN0cnVjdCBkZXZpY2UuYnVzX2RtYV9saW1pdCBhbmQgZG1hX3JhbmdlX21h
cC4NCj4gDQo+IFJvYg0KDQpZZXMsIHlvdSdyZSByaWdodC4gdGhlIGNvcmUgZGlkbid0IGNoYW5n
ZSB0aGUgbWFzayB0aGF0IGFyZSBzZXQgZnJvbSB0aGUgDQpkcml2ZXIuIEkgd2lsbCBzZW5kIHRo
ZSBuZXh0IHJldmlzaW9uIHRvIHVzZSBjb21tb24gY29kZSB0byBnZXQgdGhlIA0KZG1hLXJhbmdl
cyBhbmQgc2V0IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQgYWNjb3JkaW5nbHkuDQoNClRoYW5r
cy4NCg0KQmVzdCBSZWdhcmRzLA0KS2hhaXJ1bA0K

