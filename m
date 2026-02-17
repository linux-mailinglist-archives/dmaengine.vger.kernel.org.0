Return-Path: <dmaengine+bounces-8917-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGCdAaZVlGm8CwIAu9opvQ
	(envelope-from <dmaengine+bounces-8917-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 12:48:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974AF14B8FE
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 12:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85B86300749E
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0A7332EB2;
	Tue, 17 Feb 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a1sD2DE/"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455E26F2B0;
	Tue, 17 Feb 2026 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328931; cv=fail; b=ChIS/KMF+CfIp9VskTQ38UkTpVUcapR+UilH7foeB8WAUHRAH2P6bqiddoq11/x+RRn5ImS7G+Us6MB14Ex8UHrnJLyHZxNSkdE/DaBqQ4MeYJzEODZP6yxSjy4nzEOkPFWHJxBQ2CAZpoYNB0ismbFgXe1rjcSYLB2iQga6Nmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328931; c=relaxed/simple;
	bh=vYekDoQqWk2OS77ooHQtTOMsrcvX2QNd4Iqn29m4NKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rV7ye3UjQrg8hyltTm/GgJwI44unQWfaHMZs443berIsen7CIZhkVlRsbK6TwSPu2CVn9saPWNQCfnOUNxcQxzVEpRHeX9Yps3hrliurPJWb+seOabUi3Qss6Ms0RT+d3AW/pH0dEiP96UWN5BqZiUTcdq7FLyl8wk3e7+PTVu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a1sD2DE/; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/LVwdGVgp93zVGFJcv8rUljc7vo2UFsNXM4txtigFvCF2Zx9lGVQK+k2wWP+kAdpOo1Yqobxfd6Ou8YUwOGF5MXgVyaYWJGTptBVDXMFaDVUkcmnF9ZwpDKu4Sb4B2m+Ve7IJMnApG6y+BAfbXMsX+yonHIdkm09MuTERPJxfITgNp61KGjF6Sr5Y9lkxzU2k5phjQXXDe4hDjAnsC4SWRKmbsfrf0Cp4/CgbNpgnIpKcBzfc1ptWB+6RzQowZCoW9oieWyTH9yw/IrDRQrfK+eayez3ZlBINQ3WI2A2cI1tTURyjHJDcWGH9Njzws6XcXKnCq57Fdk6NHFS4Tfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCcRcpXv++B6KefXI23gCA9wN2zbfpiTJ8TKaiL0GUQ=;
 b=hpCcoEt6BKUZc5fSBntU20zQTB72xEqQdZYLMy03q7qwGBOiO0J4j9Fbgt9JlE5OMK49WghaoEleRKlFCTjFO6V0fZ9ksdJRrbvhuFCrUhYwblGXL8NWt68DPtuSGKOli3bX54nFdpihaUqjR4/4R+ZUjGtJfI8QGS4cBk/xOBRG8j6lY9gKJglI33Rve0nbOASgKZhirG4V6q1gTvAa8YgBvu4zjSOSBljVjfTQXdoCIim+37Z8ikHxArT3CsONWYsvIjeY9HRwlru7UCJSA6v1cjA7gXdYqSvc1wmySNgGQljH2iUdjOrK8eiOOTepy9AWCn/UkakHhj1XiUO49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCcRcpXv++B6KefXI23gCA9wN2zbfpiTJ8TKaiL0GUQ=;
 b=a1sD2DE/b2q8YyFoWRl56m7sNBlF1m1q28pXc22ZzNTTYvcn8gIElGYI6TQRypMtYupnozrI8CxEQIcCXilhJJHyQnIdxSAp0QqvzQMzhAbplHh6DRfWGqyygbXRMcDkigTUrsaN3R1tbdya3shm8182iT/W7rRouQeZy35yMZo=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:48:45 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 11:48:45 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXA=
Date: Tue, 17 Feb 2026 11:48:45 +0000
Message-ID:
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
In-Reply-To: <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-17T05:41:01.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|PH7PR12MB7282:EE_
x-ms-office365-filtering-correlation-id: 7ecbdf3e-8fbf-43b6-0df7-08de6e1a816f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zggIVJ1iNbLHoxOb+cFdvQxsg9Kb1w0/jEA7+TrII1tbpJvU9oB2NFUu7RO7?=
 =?us-ascii?Q?qf3uugQXgGm3FpT6u8FH5I0msJjXOd9Xil9BjoFw8f33ov75eB33Tx45DIeV?=
 =?us-ascii?Q?z3oVLWenWDC89nMhY85mNh8wCwKjwgvVhFjZtuwLnlSbMcQw+VThOvjSnMK/?=
 =?us-ascii?Q?vcVGWuniFblCDTyGgJmaffCaiLug02GSuxLr1D93HBabQsaA5RztWmuxGimS?=
 =?us-ascii?Q?6SBFUCAwpgSrfkpmYrJzPCh28t0Q0MFuoV1rl4VA3iLSfDxnrsFHGg44Ohft?=
 =?us-ascii?Q?UQWLS6qX+oiTvoC04N5NtQd7dgyCwZj5JiPR9m7VGdFD7bOsXNAn+WjVMNNR?=
 =?us-ascii?Q?C4EA0Xo5EjtflviET5WTwzOPugWckLEkNj6BReGgW5Qo/2tSpzP0qyD6tiUY?=
 =?us-ascii?Q?ckrw03ORzVKaWLyKDJcFmRrRAxKrC58IOw6mWddhOtFyyABlY0aYGvS8If/Q?=
 =?us-ascii?Q?xGHIx8FXaHKuT9G8QE6zJn3wp0BBt0bnFfh0/ruuqw+Uo88sAsttgf00OA0x?=
 =?us-ascii?Q?pG7C0PiXOIuP+Y5nngs2i5v9hu09MEeB8+aNny9CmmSovmypola9/EMHXx1d?=
 =?us-ascii?Q?Y6XfmiHIf9oCh4zYmgZhU3bnaYYSHyy81pV52VSgMYfeUpwjym4ZDWE9Fhlc?=
 =?us-ascii?Q?8gT9h4nq8WxRWBdGXylAVZqTskZbg71kgwwCiN2yFJkil/4mq8BUAy3qlHo6?=
 =?us-ascii?Q?urk1RZH1FfqKUFJERL4bEexBsl7Yb1tGRq4YNcP2df+By7ypoYSI7OyuHFoo?=
 =?us-ascii?Q?ZsWS/8U/M3bHl7O7E3NA2SgbsWjVmpxxkINORhwUiu2A3+zlYX2fW6hqCkDz?=
 =?us-ascii?Q?XQxKc0GUD4Kk+1F91svqm5/5FbPPYMatNT5TkfffLK/yAwzvN5B7E3IvF3zn?=
 =?us-ascii?Q?W6sURHAom0odkpQgHs4zduzpgT219KnwaVVc0YLpS2mYPIyED1eUoppN+7Pa?=
 =?us-ascii?Q?YrcwafRNQXKLOxM3Pgk9ue8INO3jcOwsIxE3LG12Pv/RXTYNETnkRDG3rmcs?=
 =?us-ascii?Q?1WnP6IC3mhKR0bHbk3f2lMS8doOtesPSfpYJowtiTB14cSWlo6YPRem50607?=
 =?us-ascii?Q?EBm+k9CAQ+mf58zMU0sc5hB4/riUZy878DMeRhv5VkOumakZ0nu5crVBuKqc?=
 =?us-ascii?Q?WNA86cgT6sygiIzrWoz6hpOlPgH5aQE09Hk6qNizrnf8hoKmWjDmSxYf9a2I?=
 =?us-ascii?Q?WZjVz8JOasxi+2PLqM9bYnG7emBN/FJPqkq0b68V9/IYtd3AbQ29qePNDF9r?=
 =?us-ascii?Q?t+mRK3eRfLi6EnwP2z0PRMSQ6wNrcbEahCwxLjM7q12YxbG145AHpUeNljov?=
 =?us-ascii?Q?lVtMQnG6urxJOtIT0Q1aApjthcEtrMRlXTGAHpozMk9SbCuwG3iGXcrCMblB?=
 =?us-ascii?Q?33DoRVGB4qOhjPiqBTBRceYGtUccFE+ZrfLb67wp6Ojf9P9slyyKYiajelDL?=
 =?us-ascii?Q?WDZnSAYnNmGaNWRqlZpYH6OxiLHqAG42IBGnBg2bBw/lbvBHJrOd0n5CurpT?=
 =?us-ascii?Q?FjDghYI20uFmrqjfNoQziy4UlYjpW9UCbsBKrEnwYJrm452VW9Rjgra5P3fu?=
 =?us-ascii?Q?abMb7TQuSj50LVztEyu6gqOc1/s3aBqYF2O3cYc7YIEv2DTytrKKZGEURQzz?=
 =?us-ascii?Q?uLLS8OLz/ln075w5d9xr7Uc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CbitUBGc8SZEj4yDopfUudJ5ffW3284c21rIZ+oYrkFd9lDKCRn9S2NCogbR?=
 =?us-ascii?Q?vPatlbhkM6gEhFT4beplfwmrVMzpn8zwc9QW/hSTD9CHIrPYrUZ1KOH2q0mP?=
 =?us-ascii?Q?RqqrsUnLeABnati05JYwEz6eymdoJ32eIZSi1HH9Zm4b16PkX2+dzw3pw6yr?=
 =?us-ascii?Q?lBMVDp4+ntgmIZX0y3Dx1AXU77NgvOzco0LGkj955ladls1e5nYHkCEJReHg?=
 =?us-ascii?Q?61oYlQMbHuNBIulnc066rX9DW7HKhktv2Dl8ebQpK/pLpkQK+Xg9UOD9lKrJ?=
 =?us-ascii?Q?7jCcRaWcOwOd7UlrxhKdOr/U0AGyT7xoxcyL4H13SWhZ/ZvPgaz3+vNyU906?=
 =?us-ascii?Q?MOBuHB24EjYqT+O+mpS5IsqP05mdkTJJGSnfMQjrXo1P0i+fzS4HwZAYMYis?=
 =?us-ascii?Q?GB7BAG6t/msOziORd4rOxtPY0bLwEL1DvzK5xYPXcMXg50aa0wt36tjph0MO?=
 =?us-ascii?Q?b4gtUIKJW7lzLFKWGjO9qPlX7QMrQulN5MH+gAtlbuPj1rRAvRdAzgwUHHwW?=
 =?us-ascii?Q?nPO8rxJhBxf9dJEjhGy5/KtOvPOgthy8v5hUUJPBJAZNbizRcOsjs3DLWRw3?=
 =?us-ascii?Q?jSPvcpvOF6USR8WuDL+S1AjDQWRMbNkqPfEki2153eQKNaUmyIqPF8nWmlgw?=
 =?us-ascii?Q?16Io3D3oii1abKNJD5c672N89PDhtgMpeUHNJieB1Lv5BRPHlsO9DhOVxp6r?=
 =?us-ascii?Q?PcWGEizXvgKV2foWA3da3Nv4z91MwMgVeUajimS5vopfAjrR3+o4BiTAaRJy?=
 =?us-ascii?Q?JW+SSdDNx+4j9p07v+W/xccgRKduACk4TYfLtGqs6FwiPCTEC5+foD7Xg7ol?=
 =?us-ascii?Q?lmZZav4y9wK2TonXXYSnYL8hdqLEjaOedtI0hDmn06g0yw/NqufSKn9WxDTQ?=
 =?us-ascii?Q?h/6vQs3UoUE9BTiN73nQ6D5vZdoCeCgbupw6AinR1gyavPryIDYjLvSG7Z/3?=
 =?us-ascii?Q?I//WFLnls+QLcLb9NuUln0MHi/vio+88+f5R7K3eeEhuxf7FdSXREh+aOo54?=
 =?us-ascii?Q?pg0OTRLBSPswNXpw5lB1KuyVxy/lZDSvejyr6ScOXA4Zske68MA24tDooa7/?=
 =?us-ascii?Q?ieGhljY5M8W39lkzHxoj6KDSwjFtczYsDfqrFJcdn+wrVOlSQrSCtzrm6tap?=
 =?us-ascii?Q?8Ma6Mc3e+KCRgcwa6aq7R4oHeno37wXIVKwBfHmPhpgPappebseuB8ClHkUj?=
 =?us-ascii?Q?SUDIAk4e+8aHp6uKKoo8UP5h/lls7S+EdJOjchaBoO59SpY1Lw8u9ZIZ/kNN?=
 =?us-ascii?Q?xaTTk0MC+3gz3z2zrwpdDoAL8IRX1vxY3ZaWt7PfFNzF90y0ctCREhUUTWLc?=
 =?us-ascii?Q?LPCu/qec8d394AxpbgGS1iYDVFRvWNqUUdXWsobHXN43DH9qinsX4LarNwMO?=
 =?us-ascii?Q?Mpi/vTqeqowLPsUK6TTeNDfWC50R3sje9k7hKkM9mnBOoWbxXVJ/cblCXo63?=
 =?us-ascii?Q?ukY42EO79sBpwYiDk62+9tBsxIdw1TQu7BxXFGuxOLTS0cGzC6G0KnUaLUrC?=
 =?us-ascii?Q?AQgRZyySAwAb8oWxLFd4Q/uNNI08jCZPkcFf22Ho1qwJ8NK58xA3sME2e789?=
 =?us-ascii?Q?Tv1QAQYtiKIUByDL84+v9iwfsGNwtUBdxQj4upeSybheQUqUuaE0gP6lAW6p?=
 =?us-ascii?Q?Gvb67HJvzYfVy2QhmM5TH+OeQ1w4DTWiYj5dff1+9fwNpN+i4fdezYQzOBaI?=
 =?us-ascii?Q?5zGSxRnUfrm5GRPcIL0k7ySXqQGntYZrIdWnhTk/UJ+ttHPz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecbdf3e-8fbf-43b6-0df7-08de6e1a816f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 11:48:45.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwYCOK4OPnueSUKBBpC2ZYWDkGum18Oh4m3qEXa6zU2rYNiX9GOy5Nh+P4MPxSd00EvuG/o+47IPvmSvYfpagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8917-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 974AF14B8FE
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Frank

Please check my responses inline.

Regards,
Devendra
> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Tuesday, February 17, 2026 1:16 AM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma wrote:
> > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > The current code does not have the mechanisms to enable the DMA
> > transactions using the non-LL mode. The following two cases are added
> > with this patch:
> > - For the AMD (Xilinx) only, when a valid physical base address of
> >   the device side DDR is not configured, then the IP can still be
> >   used in non-LL mode. For all the channels DMA transactions will
> >   be using the non-LL mode only. This, the default non-LL mode,
> >   is not applicable for Synopsys IP with the current code addition.
> >
> > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> >   and if user wants to use non-LL mode then user can do so via
> >   configuring the peripheral_config param of dma_slave_config.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v10
> >   Added the peripheral_config check only for HDMA IP in
> >   dw_edma_device_config().
> >   Replaced the loop with single entry retrieval for non-LL
> >   mode.
> >   Addressed review comments and handled the burst allocation
> >   by defining 'bursts_max' as per suggestions.
> >
> > Changes in v9
> >   Fixed compilation errors related to macro name mismatch.
> >
> > Changes in v8
> >   Cosmetic change related to comment and code.
> >
> > Changes in v7
> >   No change
> >
> > Changes in v6
> >   Gave definition to bits used for channel configuration.
> >   Removed the comment related to doorbell.
> >
> > Changes in v5
> >   Variable name 'nollp' changed to 'non_ll'.
> >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> >   Comments follow the 80-column guideline.
> >
> > Changes in v4
> >   No change
> >
> > Changes in v3
> >   No change
> >
> > Changes in v2
> >   Reverted the function return type to u64 for
> >   dw_edma_get_phys_addr().
> >
> > Changes in v1
> >   Changed the function return type for dw_edma_get_phys_addr().
> >   Corrected the typo raised in review.
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
> >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-hdma-v0-
> regs.h |  1 +
> >  include/linux/dma/edma.h              |  1 +
> >  6 files changed, 132 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > b/drivers/dma/dw-edma/dw-edma-core.c
> > index b43255f914f3..ef3d79a9f88d 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -223,6 +223,31 @@ static int dw_edma_device_config(struct
> dma_chan *dchan,
> >                                struct dma_slave_config *config)  {
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > +     int non_ll =3D 0;
> > +
> > +     chan->non_ll =3D false;
> > +     if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) {
>
> Need handle EMDA case. if mf is EDMA, need return error when
> config->peripheral_config is not NULL. Or remove above check to make
> code work for both EDMA or HDMA.
>

For the case of EDMA, the behavior is unchanged.
Even if the config->peripheral_config param is set then it would be simply =
ignored.
This is retention of the previous behavior. This is done because device_sla=
ve_config
has other params which affect the behavior of the DMA transactions, we do n=
ot check
all those params and return any error. The error is returned only in the ca=
ses where
particular parameter from dma_slave_config is used and if the parameter is =
not as expected
or in the expected form. The parameter used from dma_slave_config for the p=
articular
IP type need to be known first then it can be checked for its correctness. =
This is behavior
for the peripheral_config which is used for HDMA and thus error checked.

> > +             if (config->peripheral_config &&
> > +                 config->peripheral_size !=3D sizeof(int)) {
> > +                     dev_err(dchan->device->dev,
> > +                             "config param peripheral size mismatch\n"=
);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             /*
> > +              * When there is no valid LLP base address available then=
 the
> > +              * default DMA ops will use the non-LL mode.
> > +              *
> > +              * Cases where LL mode is enabled and client wants to use=
 the
> > +              * non-LL mode then also client can do so via providing t=
he
> > +              * peripheral_config param.
> > +              */
> > +             if (config->peripheral_config)
> > +                     non_ll =3D *(int *)config->peripheral_config;
> > +
> > +             if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll
> > + && non_ll))
>
> if chan->dw->chip->non_ll is true, It should return error if you set non_=
ll false
> because no LLP base available.
>

In case the 'chan->dw->chip->non_ll' is true, then the default mode becomes
non-LL for HDMA ONLY. There is no option to the user to configure the LL mo=
de
by giving 'non_ll =3D false' as part of the config->peripheral_config.
The configuration of default non-LL mode depends on how the IP is programme=
d
by the user. The user is aware of the IP configuration. The check for non-L=
L option
provided by the user is useful when LL-mode is default. That is why the val=
ue of
non_ll =3D=3D false is not even evaluated.

> > +                     chan->non_ll =3D true;
> > +     }
> >
> >       memcpy(&chan->config, config, sizeof(*config));
> >       chan->configured =3D true;
> > @@ -358,6 +383,7 @@ dw_edma_device_transfer(struct
> dw_edma_transfer *xfer)
> >       struct dw_edma_desc *desc;
> >       u64 src_addr, dst_addr;
> >       size_t fsz =3D 0;
> > +     u32 bursts_max;
> >       u32 cnt =3D 0;
> >       int i;
> >
> > @@ -415,6 +441,13 @@ dw_edma_device_transfer(struct
> dw_edma_transfer *xfer)
> >               return NULL;
> >       }
> >
> > +     /*
> > +      * For non-LL mode, only a single burst can be handled
> > +      * in a single chunk unlike LL mode where multiple bursts
> > +      * can be configured in a single chunk.
> > +      */
> > +     bursts_max =3D chan->non_ll ? 1 : chan->ll_max;
> > +
> >       desc =3D dw_edma_alloc_desc(chan);
> >       if (unlikely(!desc))
> >               goto err_alloc;
> > @@ -450,7 +483,7 @@ dw_edma_device_transfer(struct
> dw_edma_transfer *xfer)
> >               if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
> >                       break;
> >
> > -             if (chunk->bursts_alloc =3D=3D chan->ll_max) {
> > +             if (chunk->bursts_alloc =3D=3D bursts_max) {
> >                       chunk =3D dw_edma_alloc_chunk(desc);
> >                       if (unlikely(!chunk))
> >                               goto err_alloc; diff --git
> > a/drivers/dma/dw-edma/dw-edma-core.h
> > b/drivers/dma/dw-edma/dw-edma-core.h
> > index 71894b9e0b15..c8e3d196a549 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -86,6 +86,7 @@ struct dw_edma_chan {
> >       u8                              configured;
> >
> >       struct dma_slave_config         config;
> > +     bool                            non_ll;
> >  };
> >
> >  struct dw_edma_irq {
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 3aefc48f8e0a..94621b0f87df 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -295,6 +295,15 @@ static void
> dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> >       pdata->devmem_phys_off =3D off;
> >  }
> >
> > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > +                              struct dw_edma_pcie_data *pdata,
> > +                              enum pci_barno bar) {
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > +             return pdata->devmem_phys_off;
> > +     return pci_bus_address(pdev, bar); }
> > +
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                             const struct pci_device_id *pid)  { @@
> > -304,6 +313,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       struct dw_edma_chip *chip;
> >       int err, nr_irqs;
> >       int i, mask;
> > +     bool non_ll =3D false;
> >
> >       vsec_data =3D kmalloc(sizeof(*vsec_data), GFP_KERNEL);
> >       if (!vsec_data)
> > @@ -329,21 +339,24 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> >
> >               /*
> >                * There is no valid address found for the LL memory
> > -              * space on the device side.
> > +              * space on the device side. In the absence of LL base
> > +              * address use the non-LL mode or simple mode supported b=
y
> > +              * the HDMA IP.
> >                */
> >               if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > -                     return -ENOMEM;
> > +                     non_ll =3D true;
> >
> >               /*
> >                * Configure the channel LL and data blocks if number of
> >                * channels enabled in VSEC capability are more than the
> >                * channels configured in xilinx_mdb_data.
> >                */
> > -             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > -                                            DW_PCIE_XILINX_MDB_LL_OFF_=
GAP,
> > -                                            DW_PCIE_XILINX_MDB_LL_SIZE=
,
> > -                                            DW_PCIE_XILINX_MDB_DT_OFF_=
GAP,
> > -                                            DW_PCIE_XILINX_MDB_DT_SIZE=
);
> > +             if (!non_ll)
> > +                     dw_edma_set_chan_region_offset(vsec_data, BAR_2, =
0,
> > +                                                    DW_PCIE_XILINX_MDB=
_LL_OFF_GAP,
> > +                                                    DW_PCIE_XILINX_MDB=
_LL_SIZE,
> > +                                                    DW_PCIE_XILINX_MDB=
_DT_OFF_GAP,
> > +
> > + DW_PCIE_XILINX_MDB_DT_SIZE);
> >       }
> >
> >       /* Mapping PCI BAR regions */
> > @@ -391,6 +404,7 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >       chip->mf =3D vsec_data->mf;
> >       chip->nr_irqs =3D nr_irqs;
> >       chip->ops =3D &dw_edma_pcie_plat_ops;
> > +     chip->non_ll =3D non_ll;
> >
> >       chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
> >       chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt; @@ -399,7 +413,7 @@
> > static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       if (!chip->reg_base)
> >               return -ENOMEM;
> >
> > -     for (i =3D 0; i < chip->ll_wr_cnt; i++) {
> > +     for (i =3D 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> >               struct dw_edma_region *ll_region =3D &chip->ll_region_wr[=
i];
> >               struct dw_edma_region *dt_region =3D &chip->dt_region_wr[=
i];
> >               struct dw_edma_block *ll_block =3D &vsec_data->ll_wr[i];
> > @@ -410,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               ll_region->vaddr.io +=3D ll_block->off;
> > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar)=
;
> > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      ll_block->bar);
> >               ll_region->paddr +=3D ll_block->off;
> >               ll_region->sz =3D ll_block->sz;
> >
> > @@ -419,12 +434,13 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               dt_region->vaddr.io +=3D dt_block->off;
> > -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->bar)=
;
> > +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      dt_block->bar);
> >               dt_region->paddr +=3D dt_block->off;
> >               dt_region->sz =3D dt_block->sz;
> >       }
> >
> > -     for (i =3D 0; i < chip->ll_rd_cnt; i++) {
> > +     for (i =3D 0; i < chip->ll_rd_cnt && !non_ll; i++) {
> >               struct dw_edma_region *ll_region =3D &chip->ll_region_rd[=
i];
> >               struct dw_edma_region *dt_region =3D &chip->dt_region_rd[=
i];
> >               struct dw_edma_block *ll_block =3D &vsec_data->ll_rd[i];
> > @@ -435,7 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               ll_region->vaddr.io +=3D ll_block->off;
> > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar)=
;
> > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      ll_block->bar);
> >               ll_region->paddr +=3D ll_block->off;
> >               ll_region->sz =3D ll_block->sz;
> >
> > @@ -444,7 +461,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               dt_region->vaddr.io +=3D dt_block->off;
> > -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->bar)=
;
> > +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      dt_block->bar);
> >               dt_region->paddr +=3D dt_block->off;
> >               dt_region->sz =3D dt_block->sz;
> >       }
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index e3f8db4fe909..a1b04fec6310 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> dw_edma_chunk *chunk)
> >               readl(chunk->ll_region.vaddr.io);  }
> >
> > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > first)
> > +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk,
> > +bool first)
> >  {
> >       struct dw_edma_chan *chan =3D chunk->chan;
> >       struct dw_edma *dw =3D chan->dw;
> > @@ -263,6 +263,69 @@ static void dw_hdma_v0_core_start(struct
> dw_edma_chunk *chunk, bool first)
> >       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > HDMA_V0_DOORBELL_START);  }
> >
> > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> *chunk)
> > +{
> > +     struct dw_edma_chan *chan =3D chunk->chan;
> > +     struct dw_edma *dw =3D chan->dw;
> > +     struct dw_edma_burst *child;
> > +     u32 val;
> > +
> > +     child =3D list_first_entry_or_null(&chunk->burst->list,
> > +                                      struct dw_edma_burst, list);
> > +     if (!child)
> > +             return;
> > +
> > +     SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
> > +
> > +     /* Source address */
> > +     SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > +               lower_32_bits(child->sar));
> > +     SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > +               upper_32_bits(child->sar));
> > +
> > +     /* Destination address */
> > +     SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > +               lower_32_bits(child->dar));
> > +     SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > +               upper_32_bits(child->dar));
> > +
> > +     /* Transfer size */
> > +     SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
> > +
> > +     /* Interrupt setup */
> > +     val =3D GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > +                     HDMA_V0_STOP_INT_MASK |
> > +                     HDMA_V0_ABORT_INT_MASK |
> > +                     HDMA_V0_LOCAL_STOP_INT_EN |
> > +                     HDMA_V0_LOCAL_ABORT_INT_EN;
> > +
> > +     if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > +             val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> > +                    HDMA_V0_REMOTE_ABORT_INT_EN;
> > +     }
> > +
> > +     SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > +
> > +     /* Channel control setup */
> > +     val =3D GET_CH_32(dw, chan->dir, chan->id, control1);
> > +     val &=3D ~HDMA_V0_LINKLIST_EN;
> > +     SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > +
> > +     SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > +               HDMA_V0_DOORBELL_START);
> > +
> > +}
> > +
> > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > +first) {
> > +     struct dw_edma_chan *chan =3D chunk->chan;
> > +
> > +     if (chan->non_ll)
> > +             dw_hdma_v0_core_non_ll_start(chunk);
> > +     else
> > +             dw_hdma_v0_core_ll_start(chunk, first); }
> > +
> >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)  {
> >       struct dw_edma *dw =3D chan->dw;
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > index eab5fd7177e5..7759ba9b4850 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/dmaengine.h>
> >
> >  #define HDMA_V0_MAX_NR_CH                    8
> > +#define HDMA_V0_CH_EN                                BIT(0)
> >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > 3080747689f6..78ce31b049ae 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> >       enum dw_edma_map_format mf;
> >
> >       struct dw_edma          *dw;
> > +     bool                    non_ll;
>
> Can you check ll_region directly? it should be equal to (ll_region->sz =
=3D=3D 0) ?
>
> Frank
> >  };
> >
> >  /* Export to the platform drivers */
> > --
> > 2.43.0
> >

