Return-Path: <dmaengine+bounces-5823-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565AB0586E
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A34F7AFCBC
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4688F2D97B0;
	Tue, 15 Jul 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sN75/hiS"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A42D9783;
	Tue, 15 Jul 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577516; cv=fail; b=DcQaP6CWK/4O89qSdeJNsqu4Me9mghdBzjKb0b+IDaw2z70FZdsCJ2YXoIMw9MGwKODFw4eWUUAk4J2MOgUX3w47A2XfjRnM+mC3dWdFqbGg1IKegJrqCKAmnhyCvOpUOQqd+xLU0xsaQM0mjncNeFJFY3lHT8g0vCSwrZGtndg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577516; c=relaxed/simple;
	bh=zOCRuZ9cjjlc+M9m04cg3cKMVYLWafd1024dfuWNWN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HCyakkY5C+XC/u/M4FG/VS3ercGwiLptv2MRrPnAX2SToS1hIO5drMtyqLPI25wAOXNtjFMRVv6HZgJqWaKkTCyrTbLHwEtIrmKCS6wkOMgnCCwULU78+Mekg0eTeWuZAixb5zDoWzm9Z3ZghT6G6HPycSmWjGtTR+0DJede384=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sN75/hiS; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASeTrjhj3yek0Iv+KOuyHJHFaTxpLg8uA5f2vse7oi2w8WQLbx0KYCM1Vo9hHhF582UBqXhlyEUn/36DCFwvfVELFrHBlRHqtvJHrVhqbzKYNXnT2Bg6XVidCOQP8p+mNAvQfepx/FN+b0bQAEQynZM5oAlG7SGjVeng1Oq6lFSiZ/rrXYZmk/KNhry2CfOrwYsirqO4tCpqz8FdFCtibgbvZxFLpAkz7vWuH2jME01yTW0cA/T7QjHmkj5CK6sEPcXoRPjf3RUC6DOZ0ZA7gOQtQAL7SPmNQMtxPK5Sc2HWE45qu8Us3hCu9p73CRMOQkj/Z9YMAd9UXx+HJ6//gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9A7rNPRGDbtOu9cPg+iFatugdgfrOR0BKYq3YHejIA=;
 b=iX8o8DLrZJm0ovBUvr28iSMq8LPXEraL9mHDBVC7EeGcVOt7UYk8sbReI7usEXHD09wknNjsy4DuF5JYlWujI/DCwo47Jyu5cTG5yVlA2Va3dEIycugVSAHD9T6eqI9xxTmV7m+FRsxh6McP1J+aMrYJvZ3eFHxOO2VPKVETqxYrWNAnQY6ZVWKsTvNwubdBncR/bU4p0SNDRWFUxHxi1YTnHKmcv0f4DyNxcGDI9dEJmbMrmTQRSsW1rpnRwfb1jj4yJdfJQO33c2164CGFQfG2PZQotmGCj/SXzeUC+0bpVcbMEZ3Xh6v65lGaGznKB3m644WK/A8WMaTQ9LkfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9A7rNPRGDbtOu9cPg+iFatugdgfrOR0BKYq3YHejIA=;
 b=sN75/hiSyRXBV+tFcxZ7R91hHrtG6EHTiHQKs75MShOGz6lk4CobNc+rSj02RN/uHDW0AHnOSb1mBcSR7093SaiU91l3+rKJIddF0NxWu3d3AImbco9zHSYnKxYsj5O6RcseP1Q2OCOB9p5X+oJQPTf3I2FUWVjUZsMbRHHG87c=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 11:05:12 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 11:05:12 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH V2 2/4] dmaengine: xilinx_dma: Fix irq handler and start
 transfer path for AXI DMA
Thread-Topic: [PATCH V2 2/4] dmaengine: xilinx_dma: Fix irq handler and start
 transfer path for AXI DMA
Thread-Index: AQHb8YMykbpgUPq1XEK0FsQwY210P7QzAOuw
Date: Tue, 15 Jul 2025 11:05:12 +0000
Message-ID:
 <MN0PR12MB595348322834F80697B4B806B757A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-3-suraj.gupta2@amd.com>
In-Reply-To: <20250710101229.804183-3-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-15T10:19:39.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA0PR12MB4448:EE_
x-ms-office365-filtering-correlation-id: bf9df34d-3f73-479b-0c7c-08ddc38f786b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cbtgOY6jzlWY7eNrCWFV69p3otGPn/oI0lxOU+fx59zLhLafEyNLnGID6emt?=
 =?us-ascii?Q?e/4wyTlUHV0IDGI1PP5LwpiWW47kv1rGqicMHuWdKHbG9mvEIAyuMX3Qlk+q?=
 =?us-ascii?Q?8ibJyFW7IDii77o+LM42sSy3rkahtIsas50HFw9zQFzx1Xa5iQNRpTAZboG4?=
 =?us-ascii?Q?XWSVvP82bXaFZWVUzlJwChLv6/UageIVRVV04RSopEa3+UtLp7QSa+bGKGAQ?=
 =?us-ascii?Q?KJfqPxSQ5DpZAgLwHZyZab0krt/OmFoeuf2jvq4ctGxtyS+0virpwR1Q82md?=
 =?us-ascii?Q?ce6SUB89gbPKOma6g9BJjHdteZreK2vJHNGiTGpflTqL6R2uyWWlV0zrOdmI?=
 =?us-ascii?Q?aNFnT3162XJ9zyBvZ/FYgjeBSjmNg2yFmucvJoIQcOWsbOX/r7uF9X1DznXY?=
 =?us-ascii?Q?iu6TSECR3/0TKae1GJwFeJHLEQ+sN1Ky4LCK1/jmkh2jqBaBzkPnL2zck4Nx?=
 =?us-ascii?Q?PsC/cr8eDe6dVzyV08HMznZqITZKKwSUVPA2GIcmGqzcLAtib9FzKS3iyAe8?=
 =?us-ascii?Q?cDki9MJQDnGfo4wMlcdLx/EvIMHt0sAG85HRI3wRYWwEcvm3xSDriMT9v1Kg?=
 =?us-ascii?Q?gktDzIN7kmSs4LGbv19/kzTQyckuTtkaTdw9/eaHq0dMaQH8uCyQLMH/aiun?=
 =?us-ascii?Q?1iureODbRR4pR6vCaZKA1uM2RZ87vW5xPet5FNw/6B2pThwb3PgOBFKbrXAS?=
 =?us-ascii?Q?YUb4OKWFZi4p09JmBmtbWS29fGOCgCJEwOGE4W+cF1edGmvxlpQb2Ygf+7DD?=
 =?us-ascii?Q?WY7G4O9xcqNJeNJb7hbdcnyHISgc8/NRPypqGNXnFz9HeVeeXoOIfPl8aS1Q?=
 =?us-ascii?Q?AAsKA3pLUH8/7FyVpUTG9IVAvn7kp7HnACJaxIz5PyHFPffKcldl9NObCksX?=
 =?us-ascii?Q?ps1JsUPlmtmTn2NkjyYipLDUxKoCdlR47pzGdFBP2FFQTRRPfuyCFzT3rya/?=
 =?us-ascii?Q?XIQYVZcMZ+5T3+3O6Bw7m0JF6LilJFUxooUZp9GxpHKjxvL1Q8aHSnpbWJS+?=
 =?us-ascii?Q?8j5wkC9dqlEpByHkvI1+LDoP4fk1WIjCZEozezYpJP7MC0RUfIeIF7APxfr4?=
 =?us-ascii?Q?SpuqJKAWKFkzjZ1oD2IIH2HW8AtaKbxOQooqXjc/K5CQB495Qm86hlS/F2yu?=
 =?us-ascii?Q?7YB2f0BltFS4XJfm3P8kqKW3oPw7ytnfL0Yck6TzuEuwkWSWlhSFZZcd1hd/?=
 =?us-ascii?Q?2Fw3tl7Lr3H/sx+DgmUyEqGg8ovULca/KDe9Mpit+DGFbLbJ9tT3ppAOyXIE?=
 =?us-ascii?Q?JukKflPsM7DnjDVV1lSqtyhC4GXR9WeET73K1VYF/EgTswfzszdXpzD7fq+c?=
 =?us-ascii?Q?TwcLzkuQ5lJMBTCps6/lk1m9Vxp3JyThcPXYjPqC4Glnq7XcGJUPSDTKrI0g?=
 =?us-ascii?Q?wDk+09hZ5pc01njiT/J4UHUQZIiHSQZJZWVfvRaXWTcQ6DWFLM6+yFyhUZJp?=
 =?us-ascii?Q?H1Tt+wrGk89alMKwjO4eVFOwyDRT348p7Sx/MBBYBr+5zfhJziI0Ew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QEz6cOtcSMP5DtJRYlozoOE8etenR0RNI3IxeeTwYQ5wQuq4NuqJnF44/ZJ8?=
 =?us-ascii?Q?ieE0Z2mvDNdxILG62W8zbg8+I8vwkj/CDMjzq66CPJurJE4+wTzonQQDNtyF?=
 =?us-ascii?Q?aRvnBDXO5z88YrLlMjkIumhbiHcB6TFng0ZiZzAEVBFS3sldxQGjcz+d9Nt8?=
 =?us-ascii?Q?o/T2oxrwRXulQpbTF5DmrlkMnEcLMyFtKmcHQmpCbqQwUdPmdmLspbPLgNBR?=
 =?us-ascii?Q?oLx/qK++vFbNwBEkosjB8KI1xXcLZm3x2gEHk1OWbvE9uMKdJhAL2jAf58Mh?=
 =?us-ascii?Q?s+uzW0YS9tU4pWjP3rc27R7A+S/c5Zm8H91rAsYQ5AGsFbSRJ3yMydJ36AF/?=
 =?us-ascii?Q?ndnZGlH09aPrGNMnpKGVE+Rofh7IVIm02awKk0Q04vO3Goe2/CEM0a12VXRG?=
 =?us-ascii?Q?QrJZ3BDKQsZppS5lhIpoEoLbUqLeilJYViVifdqL8LowH4SauIektH09Ct2g?=
 =?us-ascii?Q?j3xcP71oMmuEfgJhnA69AKo+e0LBO78n8Drh2dLNr9IwfQ5vvZPRXwaSlpj8?=
 =?us-ascii?Q?W6H3r/1P4JLVcg62XRftAsEhpcvxks84PoxUNvivfnlBTh90Xk4MZgYN6roj?=
 =?us-ascii?Q?MXbLmJVv7QdCNfAfa01PUZgiHsgr/I5YclN2YTb/gDHgZq0aOul5Y4ZY3Il6?=
 =?us-ascii?Q?qHTt48RJi/4ZaYZPVGXRgI63yr7WX4mHdj/wcS/49nVmlw5Nd+WSuB22aLN6?=
 =?us-ascii?Q?1i+mxJtrU58/lWju2us8KNHaa+IrSICMbvCErCPzzbT5DwArnSZs53dwwBi9?=
 =?us-ascii?Q?lVd6eQXudX9/FZAhDA8/NCHZIM9revfQbQF43wojWMUXTrs4/aGZO8puOv8C?=
 =?us-ascii?Q?ItJcPv0xHTSoEnyMuspTliPZAh3YjIYa46QeLlQuMidZ61oZeg6EZ579rwa+?=
 =?us-ascii?Q?ypQp+JJegP0miJroKJHfU1kJXeEWlmm5lIMovaKQLzDkc+wC7b26xcb51Wkx?=
 =?us-ascii?Q?na9u4zIUjPK6ndFTEEImlsU44yCUjVWtqAIDL6vzl8DAbDaHXNZEeq62BuRk?=
 =?us-ascii?Q?iruOHGTpOKlFBLr1Ei4vJq3W3C2jFPwpayIL46+4YQEg0mb0kaWBhco+IdRY?=
 =?us-ascii?Q?LH3ySGze22s0RIh1abI64/X56Loww/nqGuUytDyh00fOneiVTXSZ392ezx9F?=
 =?us-ascii?Q?obYABRLCdu+Sxi53MH8W6ma+FM0fvvpdVqnN/govbagS+YoPxpH4+yv9w0kO?=
 =?us-ascii?Q?6hUvAGZlb1G0jrOaojCMIbRz1C2/zoz7Olnfevrg7hYnlrdVH2N7q7qg7Iw8?=
 =?us-ascii?Q?lELbHZB2ittsc4OczGgSAlLrLR7KhT/dB9m1vLLlb/QPDGmrQfLMztfNIhAF?=
 =?us-ascii?Q?ODsZTeuikJThbOVUpe1dqMX7OOEwBkFKBpOjvpbPGafXKFlUWmAp8gPLeZz+?=
 =?us-ascii?Q?DmmPenCBk4JqYl55/Ndl6O6dQ0jn11+Y8+7qPXRm1KCzg/LkLF/uNd+k9jVu?=
 =?us-ascii?Q?eD4VfE7JN969eZwtFN0alHaMFPU5HjCNjbCJmZEurTJwbk6zeJrvF6L4hqXl?=
 =?us-ascii?Q?wcmoMW8UpaNIvolJ+kB0a50rNzMTFn3Co2RTPTScRySqYQxF/Gpf9Rd7J6v7?=
 =?us-ascii?Q?X5bOU6UgTmc87WxNnTA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9df34d-3f73-479b-0c7c-08ddc38f786b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 11:05:12.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0hku0B9Gw/U94cs4iDBAvrdeSNtKVnGx7z1a7SyY9Lgn8YS2le5qNFUG7lH8e9S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Thursday, July 10, 2025 3:42 PM
> To: andrew+netdev@lunn.ch; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>; vkoul@kernel.org=
;
> Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; dmaengine@vger.kernel.org; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: [PATCH V2 2/4] dmaengine: xilinx_dma: Fix irq handler and start =
transfer
> path for AXI DMA

Mention - a short summary of what you are fixing. i.e allow queuing up mult=
iple
DMA transaction in running state or something like that.

>
> AXI DMA driver incorrectly assumes complete transfer completion upon IRQ
> reception, particularly problematic when IRQ coalescing is active.
> Updating the tail pointer dynamically fixes it.
> Remove existing idle state validation in the beginning of
> xilinx_dma_start_transfer() as it blocks valid transfer initiation on bus=
y channels with
> queued descriptors.
> Additionally, refactor xilinx_dma_start_transfer() to consolidate coalesc=
e and delay
> configurations while conditionally starting channels only when idle.

These two refactor should be in separate patch and as it in optimizing exis=
ting flow.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Fixes: Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI =
Direct
> Memory Access Engine")

Not a real bug but an implementation from the start and subsequent queue
we're not allowed on running DMA. Same is the case for other DMA variants.

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c index
> a34d8f0ceed8..187749b7b8a6 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1548,9 +1548,6 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
>       if (list_empty(&chan->pending_list))
>               return;
>
> -     if (!chan->idle)
> -             return;
> -
>       head_desc =3D list_first_entry(&chan->pending_list,
>                                    struct xilinx_dma_tx_descriptor, node)=
;
>       tail_desc =3D list_last_entry(&chan->pending_list,
> @@ -1558,23 +1555,24 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
>       tail_segment =3D list_last_entry(&tail_desc->segments,
>                                      struct xilinx_axidma_tx_segment, nod=
e);
>
> +     if (chan->has_sg && list_empty(&chan->active_list))

Can also use chan-> idle equivalent of empty active list?
But is fine as is also.


> +             xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> +                          head_desc->async_tx.phys);
> +
>       reg =3D dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
>
>       if (chan->desc_pendingcount <=3D XILINX_DMA_COALESCE_MAX) {
>               reg &=3D ~XILINX_DMA_CR_COALESCE_MAX;
>               reg |=3D chan->desc_pendingcount <<
>                                 XILINX_DMA_CR_COALESCE_SHIFT;
> -             dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);

This seems to unrelated change. Please consider optimization to separate
patch.

>       }
>
> -     if (chan->has_sg)
> -             xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> -                          head_desc->async_tx.phys);
>       reg  &=3D ~XILINX_DMA_CR_DELAY_MAX;
>       reg  |=3D chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
>       dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>
> -     xilinx_dma_start(chan);
> +     if (chan->idle)
> +             xilinx_dma_start(chan);

Same as above.

>
>       if (chan->err)
>               return;
> @@ -1914,8 +1912,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq,=
 void
> *data)
>                     XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>               spin_lock(&chan->lock);
>               xilinx_dma_complete_descriptor(chan);
> -             chan->idle =3D true;
> -             chan->start_transfer(chan);
> +             if (list_empty(&chan->active_list)) {
> +                     chan->idle =3D true;
> +                     chan->start_transfer(chan);
> +             }
>               spin_unlock(&chan->lock);
>       }
>
> --
> 2.25.1


