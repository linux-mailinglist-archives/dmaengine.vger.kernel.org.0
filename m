Return-Path: <dmaengine+bounces-4754-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EAA64209
	for <lists+dmaengine@lfdr.de>; Mon, 17 Mar 2025 07:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0337A2D6C
	for <lists+dmaengine@lfdr.de>; Mon, 17 Mar 2025 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFBA1494A8;
	Mon, 17 Mar 2025 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Imx244sQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DC4A06;
	Mon, 17 Mar 2025 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194110; cv=fail; b=fiMYQhnSo/kMcIqHkPpZf1pyd1kbtZzpgyiTGTuNyL7bT8ly1GfyqYTS4cQvbbhpUBPpRwmlBC6jq9sdmKXII7CjuvZH/dMJbFmV9dkwQzV4dyO3tbGq8Y1e3EUwXKV25CWhw63z7dYaYfnRgqxe+7g0CCLHM2FyWjFeVZxrYCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194110; c=relaxed/simple;
	bh=6KQgMQe61WCIab7u/hbZ7arF533RXQf2GuW1KPesYLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgiTjTHcEjhiDE5gUnBP7eJazauLGj/OBKL8DgjeZwc1Gy1yPtQ4aG+5aXSB3wYVWg0NB/48saepI0Kvl6mIfnqN/w7gnzHlYjkmFZ7Cf7CczMYA5bYp0qyNuCZeXs6lhuumQKPprAWqTC5pdWdQNI1u3d0biF7+e6WvZQCAwUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Imx244sQ; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhH5HQbK8EPykdekYUb6UVfRrSTPeAzwh9BftYl+b4ZlWNIShX4/qllrV05vdhCXF4W7dt4zh/dUEZwMypsl+hwT2nnwhFcSOvkg67RjSlToiKotPnjkrx1g1k7oCbOTegCBGsmY2t9FOlezYM44IvgSc9wK+PGVxSENE8JKG/fqqi8RRPwrXsrHmiWZLx16Rl7+RiqIH0CkTk7m7+hogFFs2OoY+vFzZ5glH3xapAHQ7TPrGExJe9fYR2myQeR314cc6hJlBCM/vDgF+T5pHt3PBeRYNaa6ByVKscCMtP2ISe/hztUxzelqMSAPkJH60Fc8uA5kBXY7qq9QMVZmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rAQCusrCG7Qwv2iRTC9s6IA6VInp/OHO+NCM3hZLDU=;
 b=atHEPyMn0f31FMY7G5IspDEro+oCYnJmw7ydWt1jrGu9HzeYacBG6365Bl6YgLgWVKr3geL97aXuIXGTreljYDn1eqclIolqZk1fBJBEP7Eq9E3LqxUgC6NF5R7NghEMihY93ODJuU/DQAliD/DOQvIvxK+agCMvmUI+gaOfUirbGIgzNC6DBRnEq43PMVaFETRA/ZnpDBqmO7ZaXw97O83iZKIDVZCwviGFRR46clTT+E5h7ONutdxl8RnQBshzZq4sZerMGIMNkmH2EfNkny+o/kvIya3bPHf39nJ3/Az+DLj3J8DGuqjJvP55WMTl42sfxU+ExvK/8wTWSfObKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rAQCusrCG7Qwv2iRTC9s6IA6VInp/OHO+NCM3hZLDU=;
 b=Imx244sQUXeVDzNr1esrU3RA7GOOyGsRBAT8jsLV6LRf6hxMWtFx4S00sYJq/MSIHdyxa4346ZPFi8zqhssH/qy8yt4ZWiDtd1cHpD4nqNN2adVF2/wz9exznrhUMberc2PvpV7UvOmJcShvErlbyYz0xoRBdEH127degq0WoYU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH1PR12MB9648.namprd12.prod.outlook.com (2603:10b6:610:2b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 06:48:26 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 06:48:26 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	Marek Vasut <marex@denx.de>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Thread-Index: AQHblOfyPgreEFaTb06QsgCB79kDoLN25v/w
Date: Mon, 17 Mar 2025 06:48:26 +0000
Message-ID:
 <MN0PR12MB59531CAA16616476F2E09EFBB7DF2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de>
In-Reply-To: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=03b9c761-dbee-48d6-8dff-f76a09c92cd5;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-17T06:47:09Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH1PR12MB9648:EE_
x-ms-office365-filtering-correlation-id: 3cd6430a-243a-483d-ed57-08dd651fb841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+kZYloj2KDdg5Wxvn8JsfWNK5A3Q6A48Km4kya97pqVtzxuebCxDJC0pPb?=
 =?iso-8859-1?Q?hFuw7lodWbelJqm4uquQASsjItMSh7jXCcHQxRQcIZCwZtJFaZBiNJIEKq?=
 =?iso-8859-1?Q?53uCXz4RPU6ktFJ4aJkl2jv2XbLnsdKfAX2qbPsdIq/gYwiiax18f40bfo?=
 =?iso-8859-1?Q?7ZOXXEJtTTZ2KXpIOlER+BAkALbvHF37RZW4sH98FYB1sjonPqAZN6Tfc5?=
 =?iso-8859-1?Q?P9UzSRuDvb5zAvwhG85aaeaASanm7jJFMJcSi8DK5JMbRjJ9D3/8274JvE?=
 =?iso-8859-1?Q?6BhP/rPEnWSScjlJlRgUuB7sCAnMZCv6fplSUH+qF3zXf2oRYDCvg8iWfB?=
 =?iso-8859-1?Q?3iM7My+kVsOucv0IzPFwCU0SYFzHj+Sljyt0uMUqVHvVIHIstQfs9bwAIX?=
 =?iso-8859-1?Q?+ULPi6DxfPYJhRDMIeNLU7L2vQ6wjhKEtSq74Ylc7LCvdOaNI7r8SppURE?=
 =?iso-8859-1?Q?AUykV5W2e2faB0vUffxzMEsJt/cFeoILkUY8NmOzG/SCqhfO5tCovIyoaC?=
 =?iso-8859-1?Q?OlJmLyBuF+mCfifHvHv9yyIEkOdO9TUOT6YGU18rynZd0SSGYC8BRla4sz?=
 =?iso-8859-1?Q?wemO3N0SeF8K7UIjDRhVkhDd7pN8/c/RY3C3H0mHm8VFVrkFTvEt6en7OJ?=
 =?iso-8859-1?Q?rb++8jRxYVhGSnifWJmBSb3bOFu99OIz81qnzxXDyNobXRGDH6H1XVxfst?=
 =?iso-8859-1?Q?mtFUns21dKTWmxYfqLfkK7ziviX1+pCwi3ZDGG4CY0yLJjP+RFk98IQ71C?=
 =?iso-8859-1?Q?VzjR864l45DJgOgkqMB3SihJwed7VTKRX5QCMj00ZCbOES6+UkP+Tsaxzu?=
 =?iso-8859-1?Q?X3lLYpqobETX4dIHB1Pyr6x2eTxkLElIMKmS6uZlLwd4KLXvU9KGwyNCdI?=
 =?iso-8859-1?Q?6WLKcy04gpCo8Iy+pTJPNIBitq4j24Hl3Sk+mhcJoPIrhO4dczv0dgsSZE?=
 =?iso-8859-1?Q?6EvrcYZAKj3keQymd8sZgt42J7xPBi9xTDdLCzVss/qZpeKLp/t16CIo76?=
 =?iso-8859-1?Q?T8Hww85bAvdxgR3edvqcYN0IDfJGEvsagTRh51sBgZ5U9yAN56PYF7rm6C?=
 =?iso-8859-1?Q?X311HfhLE2OZ0nHslO/vl3Ykuv0MHU9x/yImZd0NaK5/W3dKGwVk2J1L/W?=
 =?iso-8859-1?Q?x1dXSWxKI4tDdnnJ2hG+e7/AarSSCOeqO0i/DseoljDEfyF+oDPSQCn5zH?=
 =?iso-8859-1?Q?zOONl29hiwXd02SitEPOvB0H8YdKUe+61p/jBWuStKC0lBT0VVR6b2tm8/?=
 =?iso-8859-1?Q?5TG1rcMjyvuRSksEjPSbWA1560Q7dWGovKQuQIoLpI9gJ+n/AZs89TpacG?=
 =?iso-8859-1?Q?PS0imMV9lqHoIakFgiouMsW8r0AEl+Q7Zw8iXCfpxTN3sgYD8OrQk7sEtq?=
 =?iso-8859-1?Q?e1PcsCbBpcmSbD1BWtHPrL18N+jUNj4xvC9Ec0rIwsLOXpGr7FX69cU4qx?=
 =?iso-8859-1?Q?XhHF8upZg+DuRuoXUpwkf8uiaP7iQJOzQXD58aR64tgx8hrJa37DlP2YFA?=
 =?iso-8859-1?Q?E5augB7mZeB3XbhUT2UjsK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8xBIS/w2UI9acpJOeek5rlT4iBQuiMp+K8BwXLmPM0TbecU7xO1J1yFQGr?=
 =?iso-8859-1?Q?v+ydjT+l1BEwjLDGdjQtSql5Lu8ep8++PbPg7TrELl61bfKLIquA0Q0h6A?=
 =?iso-8859-1?Q?UK8pP+xthRutS1aBT3IG/5M5LvIsn4ckUWHTAXkUVQYbRfWfijxAF7xHmF?=
 =?iso-8859-1?Q?f9Qr+sM8KE/dpWldgSURpAH9nMUjXKGglI5LwzdUKOhUqCkppeaHKkeIbk?=
 =?iso-8859-1?Q?PFRdsm08aPNghdE1/ekSzeboMyyiwONbV+F/8MsjQxTYDhXQ8JROClcH+/?=
 =?iso-8859-1?Q?KOjAyP2DNYwgb1ALGR2YUC/kEKvcVbbrKrIpnmEPOs0GWD1egEn9n9pCsH?=
 =?iso-8859-1?Q?srJdzCKTG9kYYlEJQuOQOVrEO97EcqlN53HqP1Vf1+CShZnQ7o4UAPwmxg?=
 =?iso-8859-1?Q?v5IjzFF5+Qlr2yFGwaqz9VAdjdr5c/pr53DJJSAGLYoe5ij6wTVkKpXsgM?=
 =?iso-8859-1?Q?0LCN+Zp780VVzaoKCYT9zy2Dlgs/KxGY1Z2ZQ4eHpEHzp7tHbmnhIZuKJo?=
 =?iso-8859-1?Q?HgN1ezJVmO8wE+4dHeGLS7rEY1pEMYG7EcF0E9wMvTqyNXV6qBhYaMWXJw?=
 =?iso-8859-1?Q?TYiaKC02dhKVE3OGibCJzVaeAjxsjNVFfVQb6EANDdLyGYxg1kYyuYQQ9m?=
 =?iso-8859-1?Q?dT+bKnmjHZYSM/mjfsYkHaqCUYyFn53PedQxkXchDTXD1fvpj2w05QnITf?=
 =?iso-8859-1?Q?lilgff68lAoYRTivfaoDSsXnwQI9nrauvolHQevILeiiH7qCJtqZpu+zoN?=
 =?iso-8859-1?Q?JnaOmPsHeDP2W2996w9Fo2vP6jDY/t4GKeq7AietEXf17lAo9mE5i1ja3H?=
 =?iso-8859-1?Q?mBNPRibCwviOG+Apuk7QtWEn8EsqL3atIeuDiSWJ3t9wH3tykg2Y+UtyRO?=
 =?iso-8859-1?Q?0HLoYrYhVANMtj+2HzWUGx/osCreikNikhg78epUBqZskW8Ec+Vaj7sMMj?=
 =?iso-8859-1?Q?jck7BMRykiWEJkAztFtv9AoAq1XfG6JJ9+iKcnrU3PJe/NJYR+o8lKllsF?=
 =?iso-8859-1?Q?Bwtk7BcsWSf/3GsVsc6U98E1LzEBteQmnt2eyw77KVuF000OccYQK/NZIU?=
 =?iso-8859-1?Q?hywB4f9qxjSZEcAqj8yuyR2qV2QxNHFyUidCjmss8MA2XspJ/sQZU7lntQ?=
 =?iso-8859-1?Q?Ce4TYfHu5rusQG2XdSyZwZu3jLIp3rqulj8IKeRslQcYIaY+zCw6VT9Vm4?=
 =?iso-8859-1?Q?9tGWvnbz7h5eVc9hLFjfxHJLlK2vxjBWdJ/9bD4L19egxsKvYkGeShPF+7?=
 =?iso-8859-1?Q?fXbltiJTlKPGJw0Fr6jJHJem48ArEWo4vT6e/yk3MRTsxZ/gswz77BRDnL?=
 =?iso-8859-1?Q?NpzAdtUcT3JFbNkSS+whfv6coyGIJ+B0GCVNtot7vJmZneHSBoq/cTFVwd?=
 =?iso-8859-1?Q?T7h8cfeaXK+wQEnktzfhEioJj/QYyHwdNQ8GFULejGGpumGgUSHu6qFsfP?=
 =?iso-8859-1?Q?jrfhf9FYX4crs1ZM58T5yD4q4TWwMPhJoArSTgpslcjxlYXY3WlHAzxFP4?=
 =?iso-8859-1?Q?+pDtdx463HqEGMBRloduXzmzU+TrRuR1hu93237ikt7o2nvL3wr3pkDOOf?=
 =?iso-8859-1?Q?2mwJm7twN5LCKEcb6BSGslNc54w2JvYp3w0b+a2OfMxFz42T7lUPDn7Ps5?=
 =?iso-8859-1?Q?3Tkqdw7Us78kE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd6430a-243a-483d-ed57-08dd651fb841
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 06:48:26.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFqBDStgucpMCSVKvvxlWXWMEaL9uVSkp9g9e59Lgr0avvyyyqpiGao8OI8XZR0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9648

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
> Sent: Friday, March 14, 2025 7:19 PM
> To: dmaengine@vger.kernel.org
> Cc: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>; Vinod Koul
> <vkoul@kernel.org>; Simek, Michal <michal.simek@amd.com>; Marek Vasut
> <marex@denx.de>; Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
>
> Coalesce the direction bits from the enabled TX and/or RX channels into
> the directions bit mask of dma_device. Without this mask set,
> dma_get_slave_caps() in the DMAEngine fails, which prevents the driver
> from being used with an IIO DMAEngine buffer.
>
> Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 108a7287f4cd..641aaf0c0f1c 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -3205,6 +3205,10 @@ static int xilinx_dma_probe(struct platform_device
> *pdev)
>               }
>       }
>
> +     for (i =3D 0; i < xdev->dma_config->max_channels; i++)
> +             if (xdev->chan[i])
> +                     xdev->common.directions |=3D xdev->chan[i]->directi=
on;
> +
>       if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA) {
>               for (i =3D 0; i < xdev->dma_config->max_channels; i++)
>                       if (xdev->chan[i])
> --
> 2.43.0


