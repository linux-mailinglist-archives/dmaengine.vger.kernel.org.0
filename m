Return-Path: <dmaengine+bounces-5106-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE33AAED16
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 22:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC863ADB27
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8E28ECC7;
	Wed,  7 May 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GH3tU6cC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC91C5F30;
	Wed,  7 May 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649890; cv=fail; b=JD8tQSrIVgckLBDDWoFYtMW8YR9OB1Tt50hCaml6aNQYzt9wfr3mtMGVB1GR9snAYQrD9x7bMQIPFLblR8EKaBMU5PMidIUFxPyhS/0KhHofZSxyeiAUNki030ic5SwrCErQsqmQaQsfTgS4H/zrLXyu/0QzniuKJBacBPJvK18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649890; c=relaxed/simple;
	bh=ze9ElpwNYQOvKEYPfiwffb0SGPFs8rGFe9zVMtSJ0y0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EvZGNelnAQD7DDmKx6xvBS0j50coTtMkL9jNmhoTITIS69SrkGVfXEetRUrdP92dLXA2sEByPkQ4E5AdjfVEo63b78NLlARMLCS5BSuWRsyImgtF5/yO0anhAlXuL6qQOXL4yvYBtZzJCqK+mz0urFyOr/zQQnizKKYO9lNe7KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GH3tU6cC; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrkMgPCYyt2gLQenQ3FpS8FzIzKmqTA7eMHju4rG7gr+i4gPAYpjvvB/a8PeHJkC7Hc/KEYkKbApV6pJr5et72DmnMwLIQq4S0WyglofN3KeDHkuGqvDjOzUMWVdUVAp7lXxf+uu5lrK7Orv/aqm2kmHQBW7sacHc3Wvboy77X7yDmp1edf2YoHEasMS19aosN4+los6yenvbfcD9TsHdjE1v+q3mYgm+L9cK/SgukNigDSY0ZJsLUpUNyCj1UTsDqp5ON7bSSao+p2elroNomw/KkVL8ouq+b+kOI7A9Nyb7doKrRfL9Vt/3NoSoUEebu1jQkEd0aPUiy4mCZh3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6sSAmtzTagat7rHHCWh/1I7DnYwJFbhua2ya+A8oK8=;
 b=JsTLHsux21e9WIO1FylMcQc5d3mc8nqDNqpdQ7Cbx+ZQDNJ3Ajmv5y56QVOIslAVKH7aeEdD8/kgIbQ7bleCFyLvEB2aIqz3owCjK5XXmLcrJ27KJEMaTzlNmLc1N+cRDys7U4TmsRnu7GeDST5f4XuL8bMQVfzKHxRNY35yrsXsPqI6ia5R/UtMEp9Txar/dBtS+SHWKSN3jMnlv71liiKceNKzxAwbJpIh2Hxo56dvVfI9g0k6+aeMh0WTM1fjCwKbAc/NxMGHiOaUc0qTScZM5CAckV+eha9Lr5T5cMql8gJsZeY2yjkbESjJ0vhWuRFMCJApm3UGy86X3WAYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6sSAmtzTagat7rHHCWh/1I7DnYwJFbhua2ya+A8oK8=;
 b=GH3tU6cC5O633fR50XNuiCN7gBHNg0iV9FqdVLnms7E8wKYYwho509wWs5TkovlIUToqxWRGYZKHPhuDEim4ZW6UgKfyxD3a4HVco5++LYOBfJgFuSAN+boZ3pRjfomMtmEhqCO4Yr7bBrsmaeFYYSy9HIbVMiOGN/ew763gfks=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 20:31:17 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%4]) with mapi id 15.20.8678.028; Wed, 7 May 2025
 20:31:17 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vinod Koul
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, "Pandey,
 Radhey Shyam" <radhey.shyam.pandey@amd.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Marek Vasut <marex@denx.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Katakam, Harini"
	<harini.katakam@amd.com>
Subject: RE: [PATCH v2] dmaengine: xilinx_dma: Set dma_device directions
Thread-Topic: [PATCH v2] dmaengine: xilinx_dma: Set dma_device directions
Thread-Index: AQHbv3zfM4FyfWDN2UicmQCtxvGIrLPHno/A
Date: Wed, 7 May 2025 20:31:16 +0000
Message-ID:
 <BL3PR12MB6571C982D9D8DC190414F21FC988A@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250507182101.909010-1-thomas.gessler@brueckmann-gmbh.de>
In-Reply-To: <20250507182101.909010-1-thomas.gessler@brueckmann-gmbh.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a04196d6-f1f2-44b4-9968-a4b12ee52b8f;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-07T20:29:44Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|PH8PR12MB6987:EE_
x-ms-office365-filtering-correlation-id: c6d0f9c3-8540-4a80-6a8b-08dd8da61e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?we9GZVxeszqpRIgzHINq02IT45dJdzAOZoyAl4qnuh/uIYHuyRRAfutabG?=
 =?iso-8859-1?Q?USBOzBpZW7BY9sXTtQTpfRBgfj9jueKEYLuPDwKQHhZBXLw9zUkqTBBdMD?=
 =?iso-8859-1?Q?9/Z72Too5h20VWga+6Z4KNfGlrttx861V3Lt4kVRKSOBUQAu5fdFMjWlMU?=
 =?iso-8859-1?Q?L2pfQ4woU2hdRDmRifkpTzOQhs6V9FcV7IPYdBKTQciWescn1SkCyVpqN5?=
 =?iso-8859-1?Q?Drmn51DEclQxRBjQ90hcZmFepcKAo21G2l5wc4bViFZODbtVWZOZPav8ox?=
 =?iso-8859-1?Q?OB669u5Ag5A2HgA8oWt8APBdNXgFNOIE71pzGEvxT2ljXrVE19TOI0EC04?=
 =?iso-8859-1?Q?GDYwk/TxYPC09qByobbicV5N4btMMVBEsr6clUBpK2xCTZmh5OqKV81KYb?=
 =?iso-8859-1?Q?kcSh03uKABYH8JRzxZ6yIE5nZ9D9hTfRL2c/3UoGOE71doyYnAH0aFziiH?=
 =?iso-8859-1?Q?7kGInz+6SRSP5Bj8BmJSGwktf28kg8HS5DIspaNzbFtr2lCUfQIi+r3xd0?=
 =?iso-8859-1?Q?CcufaO4p9vY99ugcEh2EybJOWZtXpjfEoLrIO7EYTVxJh/JBhGcxdH0b04?=
 =?iso-8859-1?Q?xiUUmaFMq6t/bBNLbh13C/uVY8fv/sCkJUx+XbGP5cfW74I1Mg0VJx/pfU?=
 =?iso-8859-1?Q?6BUF7Ct8V91aVYGjxnTrIrIDdzKq4eXk9B/autkvhfsXGz4jof/wOogE2Z?=
 =?iso-8859-1?Q?R+M3kAGHhHqYqSa9dmmAaUTFYORUIVHydMuZKd/F+N2+oum7STEt1PfxFa?=
 =?iso-8859-1?Q?KgBbsMuBn+a+2xIE2suJUdikbcehC5JtP7GKDEI1cqldkXjgiG5t0GB5z0?=
 =?iso-8859-1?Q?K2MHsuKByf1bcYD0K+UqmUmbBH033Z/R1TWA/SUlOx+0TV/IPY9g1ugPRJ?=
 =?iso-8859-1?Q?4+YI9YlNQVdQXCKNh8JMHRn+1AvIYr38T9vyBzYndWvg9cSkatzUZ7RGQY?=
 =?iso-8859-1?Q?0zz2rlcVpu4WO5pxlJAsD+EFHA9NcUdGjG1T8aAj9cwV0hxtg0NxKh+6HO?=
 =?iso-8859-1?Q?wRTlGWHX9njigxRQ+k9+zXjyrqYrwmkvNzuT4Ym45cBGtMEl/SKVnvewFR?=
 =?iso-8859-1?Q?6Y2kqVC+5FSXZt6XJJQqUJHTyhDVwDBqV25gZ8bBBV917TsMxgyTMc9i6z?=
 =?iso-8859-1?Q?q2rYznnRKEYbAb5W/3gyFdQWllyWi5xF6WQ7YebiRkSF8jpz2qu8Xhc6sS?=
 =?iso-8859-1?Q?oWfpSnHFZVmI4QZRN6zJX8s8RbtaOdZmS4jrjaicsjScBhuOcDAdnhBRcs?=
 =?iso-8859-1?Q?k85hjQFNR0mDfcBlNEgrCs+kzJ5c69hcrKvlZaKvKUfsNylPEqUXwjP+Cv?=
 =?iso-8859-1?Q?96uTk9j88cUrSkjaxuDvKT0v8N69rdqBwywn5nSDkPVDwzs45njWsbVyX7?=
 =?iso-8859-1?Q?Lje5Ziii7sL/XrR7B0lMkcd4r8umE9VtUEsIsCU6PA9hSiJzYG7ZQTLs0S?=
 =?iso-8859-1?Q?tGirGl+zsyh60mRSmTXLE6RZdBrSEIplYm9D7sG1d91k0bV67ZR0mgukgo?=
 =?iso-8859-1?Q?FAV4CFzs11WcewOFHuMMg6KjXlnxdjeSYv/T6cUQPwtQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7oqUxofcfF8knBJYjZqbOxNSd9LBQHA6w2EIVZr/sk1fUo5I9kjHMv1zVQ?=
 =?iso-8859-1?Q?UvHMfS6MYAfNYL5QZQmwcb7Urbij+UrfAE6HuUJRWyd8PMLXcxDMUOMUf/?=
 =?iso-8859-1?Q?bfWOa+lETP8q4vu34Erug6a0Msw31xBh1/7CQxsjM4LqqYBTxMfVykj9x+?=
 =?iso-8859-1?Q?b0mo9oCTETg67xTzcqxCX4gDaldQlCCMyIIx9Kj5o3HTM6jjDb0UzH5a5c?=
 =?iso-8859-1?Q?vV/NLNMwT+SKImVMbIka/WOtVd6gvpRC3Is2sW/Bcrx1E5mWe62OiuBw/I?=
 =?iso-8859-1?Q?keBcyi6ItvKBpzKeJxr07AMhgU5S1xTS3ueFzR90DAXz65aEv9agpYmspU?=
 =?iso-8859-1?Q?jHezd1TnwUkzi4WuFv523eTQFkNGNIPKfsshkO48DOZUM49YpF1MxoiRus?=
 =?iso-8859-1?Q?EOMs2LDiwYC6E9m7v8/lxmmsuyyPj+2PR5WYsuSkEEWLlu4JQR1Zo0KqSB?=
 =?iso-8859-1?Q?NeKCWHxokrI+uwwBvgbO3PgFCC2nr1tbHvCpcKizHf78wjJjmetVe78IPf?=
 =?iso-8859-1?Q?hf2rWvQhyaCP1wMiqGDa/6lSi6h6dOpICSMWQ3cbg6tVyF/gn5GWlXzHDa?=
 =?iso-8859-1?Q?7+rLkcL+Ut4/PJSjk0v+VPP/whoC+Vc/ZHHTe8Aiq1s/iYNH1BztxMHEpI?=
 =?iso-8859-1?Q?jc1gjIHibbKK2d+/nk4yclJvIqhsIoL2paiVCSr9WRRXB5b9kr6CICbC1P?=
 =?iso-8859-1?Q?AdWJCcY3aDciOolDJnFRJyZku0c6pmHhH3PJeAnsZzR1mBx0nCf3hUkyxP?=
 =?iso-8859-1?Q?eq5NQxalYLmrdy0VjtPWE/pj+PYhsJWQ8JXkujTs00RaODNtT4le4hwTB7?=
 =?iso-8859-1?Q?Y/GiELtwSkdi5gzSUKg42DnO4InUfMMXJ6hRrxQ5bp91mKs7/4lJxOt35l?=
 =?iso-8859-1?Q?kc0GgKF3e1PglucauB3WDjIbExqnjST2Wx1uKz2Ac0svE72nxY24abu7pQ?=
 =?iso-8859-1?Q?SJzojw/q7g9NR3/01LokaXNx/sJQghSWVi4bVNmJZ9QjIN9OmBqpbZkCoE?=
 =?iso-8859-1?Q?SlrfXi5S1pTVg9uqaEn5kchYf2phORLd5x+W5W65+xbwCpya+7d6wiI6XU?=
 =?iso-8859-1?Q?9EQdGsRcuYWbWvUe8NDrr1w8SXhikeRfFiiEy3hyS/YX37b54al/1EFCK6?=
 =?iso-8859-1?Q?PCLSVyjBvgOBGqSBY/NIMdkNpnYDkYWLYaGw1kA5C4pBCVUGkpYJJhabtV?=
 =?iso-8859-1?Q?+mofJYkckOCVf7EsbU9rgLufKd9f+3iCiBlilYOZgHRM7KWrU5AjOtWv8I?=
 =?iso-8859-1?Q?oUfBWGt8M5vsyzblgeOlxP2kUrDbq4Vy0ABM+n8ty89DdESbruO6MJ0sZ/?=
 =?iso-8859-1?Q?MxnIYuWUuEQ11PLgBMkGQgwbeyzbmbphXH4C7TclWm4opMVzS+8n4XcxV6?=
 =?iso-8859-1?Q?n7Y9mqWL+qPKubv2em5WQSk1+86H8N1ItUwpXLoUeZy9yn2Gx03aIyJRip?=
 =?iso-8859-1?Q?xpsxXVx3D9wvh+mNdn5E1VOeyRFZydlByvZHYNNd5cqYtGx2fGKF8YlPhJ?=
 =?iso-8859-1?Q?cIuCuZ+UGZMa0qhValTDQLgHEWLe5p0h6wxHHF6M4Da1SZANNRNEDzrNAq?=
 =?iso-8859-1?Q?huMG2gBscc0lWDfBUdkNGuosATZDcXsSoBGHUzP7E5BHOvofnSHm63pCEy?=
 =?iso-8859-1?Q?HfpCnWeSGECFM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d0f9c3-8540-4a80-6a8b-08dd8da61e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 20:31:17.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5pbvCLrbP1ij1kMawc8Ry/5y2uOSvFcVaUfG7cuZ+qlYmK0DaDoAAAe0QJDyuUn3i0pHGiD5sCmBiN4P2Wh+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
> Sent: Wednesday, May 7, 2025 11:51 PM
> To: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Vinod Koul <vkoul@kernel.org>; Simek, M=
ichal
> <michal.simek@amd.com>; Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@baylibre.com>; Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>;
> Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; Marek Vasut <marex@denx.de>; linux-arm-
> kernel@lists.infradead.org; Gupta, Suraj <Suraj.Gupta2@amd.com>; Katakam,
> Harini <harini.katakam@amd.com>
> Subject: [PATCH v2] dmaengine: xilinx_dma: Set dma_device directions
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Coalesce the direction bits from the enabled TX and/or RX channels into t=
he
> directions bit mask of dma_device. Without this mask set,
> dma_get_slave_caps() in the DMAEngine fails, which prevents the driver fr=
om being
> used with an IIO DMAEngine buffer.
>
> Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>

Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
> Changes in v2:
>   - Change to Suraj's simpler version as per Radhey's request
>
>  drivers/dma/xilinx/xilinx_dma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c index
> 3ad44afd0e74..8f26b6eff3f3 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2909,6 +2909,8 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
>                 return -EINVAL;
>         }
>
> +       xdev->common.directions |=3D chan->direction;
> +
>         /* Request the interrupt */
>         chan->irq =3D of_irq_get(node, chan->tdest);
>         if (chan->irq < 0)

