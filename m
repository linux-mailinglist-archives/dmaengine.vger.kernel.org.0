Return-Path: <dmaengine+bounces-10889-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKw4CQwwFWoRTgcAu9opvQ
	(envelope-from <dmaengine+bounces-10889-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 07:30:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 255355D0D8B
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 07:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32C6C3006D64
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 05:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166ED3BF682;
	Tue, 26 May 2026 05:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JIix+19s"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AA3B52EE;
	Tue, 26 May 2026 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773446; cv=fail; b=MyNORXRN7H7dcJAJ8erD0ViHeJXRWkfIC81M8OjleQvN9MvLHkuapm1P9IHVxvKvRt5iqj9II8MVFN+qU4BidhaQU7zOj+jAY336tQgOWl2z4axSPVcfFDiEaaTnqCdAdioGysBKIgDKQK2boQ+txF3LDRySBmjeJjkYv/wxnwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773446; c=relaxed/simple;
	bh=+J0K1a1Hu/G8JqDdsLjmmncmSK/RKilABV8ahyOU8KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nxM4qO+gmHiOhLReh4ir1RqMQw1RdLjNsksgUbxu2k8PSyYJ4l6QfHcNeqmr8rPWeESlSKq43jNgOYLyM1Ld7+XTmcAzDMNx9cwlJlPrzY1Evia+45PPCASqMs9NO3Aex7VixGjMEJYqRv1OETo5at8DvjHkyvxr6ineQERLTJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JIix+19s; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U70iKSSFFX9lUdmVtLyNcLqAY8J+Br/4rwCtx1lK45iHd1dPaHO/5GVhynmHglVTZLP8e9SBg0PsLvweSxTXcVhT5nP33TC8gwu1ErFURBXCI94FSQHuqK8Q2Rp4PbjwGTNBujtq4LIr/Tps2v2dP4IL2Euv0+fyTZHV8nMe9EqTewedFMyy/CJC5XQFXdcasCxe3pRDhJvDRaeSo/XVuIX5EYC687cjAXbmA679ba3EEwHxy20yTHdtP5nYhkRjWMISjw1YmnjSZYY2ZZpiTRRG7xIJr5tKkTTIcw9GXVJbJYt8CwVHTeIuBjGpK+0KcZznw6Wr0WKL+vZ7qekAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+J0K1a1Hu/G8JqDdsLjmmncmSK/RKilABV8ahyOU8KI=;
 b=EtCrsfBbmpAX/PG8CHCAvygu+Wip5FDcZZlh3E3X2caEgZFzwxYKCuZ6xsvhN72+nZDOSVgMMnggj+oKeGUs8SlTKjHqRw9/oIRCnjMWZiava/sOjhfgaMk9xEcTLhmWZ3Mx/usRV+R+cW/+xd7S7U4MCpdz951+D4WW+v2rqVWncxUj3BsAlvyFo6HmdF704mAS8/02xL1SN12U+HvjjrY2AgI3t2KU6+QxsUX5EFxVfiafxWPs/j72t0YmfRLCrjb1EmQPSMhIJn1H5R4OSn5fG6DZI9tkPE0HRXq167dPTbBNlIJcM9eRy80woya1SvC/MbryD/6BlIk3E8Y0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J0K1a1Hu/G8JqDdsLjmmncmSK/RKilABV8ahyOU8KI=;
 b=JIix+19sE0pGBmTkR6lx9in7ozCB48nwWAustJ3old256Yxrn5VCEkJThvXd7xRCVJ6JfC2xy9eYw/0IwtVmOg1Ybs4WSUBhmN2P0IWVCjUAPN9UlltW4yIsqYCnqXydT9IkWQ5JLCkTrL2hXVIdSO9qhmBhFbBl3tTJzzUY+C8=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 05:30:41 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:30:41 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v1] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Thread-Topic: [PATCH v1] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Thread-Index: AQHc6ytdOImdyXXl1UWAStCA0nadZ7YcgM6AgANJnEA=
Date: Tue, 26 May 2026 05:30:41 +0000
Message-ID:
 <BL4PR12MB948259AB757205BA57E945C4950B2@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260521100640.3333076-1-devendra.verma@amd.com>
 <3o7rek4lwnp7saci44acwxdxfhr2w2hd72feofcl3gipbofcjv@iazqkn57gqvl>
 <f6kwerrf2x7n7iy52mprq5zhqikzpdqbl5anzkrutvlyehix4w@ffks4f22nmme>
In-Reply-To: <f6kwerrf2x7n7iy52mprq5zhqikzpdqbl5anzkrutvlyehix4w@ffks4f22nmme>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-26T05:30:22.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|SJ2PR12MB8737:EE_
x-ms-office365-filtering-correlation-id: c84fbf9b-8f8f-457b-89e8-08debae7ed2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003|3023799007|4143699003|11063799006;
x-microsoft-antispam-message-info:
 i7xgDo9JXcdXALYnmQBbIzevyKirL7Bng9c3sYNU//3OIh5bwMLWcX2desX6vdVtJLrsVdafqmdtiwRJhMRvAZXd0ddT30vWn3yyk66RO2z7L00ORygKuT2FbDP+eJC62YlRqmuV00mkPQ6cxirSgCNqYaJzgoSBbwP/fozHOLdWSE9GLZDVPH7ilEIpMRUi45siU3zjwQb/7Y53g9hSNrR712l3r28EKdKpNLsfkgCO5BHBdUquK0fMVxb6TN3syRV5Ht5+7MlVS8ZYzdwhAyb77tJf6xNTKiqNoZ4CSifQEraO06U4OXrbdoMDqe5BkGHqaz03MrWvNrsd8IhgTE3CplwQpPWI2HiW5wsmBMpG3n7rQ5hjR3+BdL1IIGdxF9FiWdwotSDMbnkFiDfT6YWmyc4Pp53Y0ekGEyjKjDO83AAV8uvxKD/FSt3Ks8JotFzGnjwx+SWYiRV+YwW4RSGgWNTpvYbgYCa7qMFjaCVPRB0kgM88Z0ljgZgqYXFAP+M6xSYgF23x+kQJQwNObhnkH4tIlZ6CnaBP1A1MWd8yA0mU5x2UCnaXbsUWqM8bTYG/VR4Ij0UUu9RsbLALbKPNhszfwe2Mi5TWOKXvkTSgVtXDofqLc8KaIFr1ZXPf+ADF/F2kbffy/xbbKa8r7TsZjWyzJs6i98xMyvJBDO2cnKs4G0nx0nb7FHjsWt/X6RtBz2pz/KDSkYZWuCUcFYT+hs4KoYCWQg/L3i8CET0vGqZP5fCKacazX3oPAJKG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(3023799007)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXgrYXl6QWZuN09Bd2VFa3p6VDhHK1Jsd0pyc3o3bVlOaEg5eXBEL3R6dFlW?=
 =?utf-8?B?L3FvVXZpOFJjYzBpZnpYSklOVitRTUEybnhuWUVTanh1WVpMaWJiWlNxL1U5?=
 =?utf-8?B?N0x1dEZCajlaanhlUDMxQzNZUnBFeFcyUFR3eXpFVVA4UzF5MHc3MzVyOUIz?=
 =?utf-8?B?bUZzdlIwMXNmTDlRNFNCdTRIYVM4R1ovRzRVQ1YwRlNTVW5WUE5qektqd0Mv?=
 =?utf-8?B?KzZGRHpra2RTZDhOYjk0Y2RJN3N1eXN0eGhtMUZtL1FaZXo2ZE8wNmlmY0pO?=
 =?utf-8?B?T3A1Z1pVM1NTK3B1NFZIblZ2TUZUQk5qNGtaQ2lhZHRZUjNoK2xIWjBUVThM?=
 =?utf-8?B?L2NCZ3pWejJhY1Q3eTEvL25OUUFRNW9ITHpzWVgrY2V6ZlUrZTBlbXRuUFRx?=
 =?utf-8?B?dlZOYUdJcUREQXhCYU1YTlY0ZEJBcGpETDhaV2k2WVI5OGJGQWkrOFFOK29D?=
 =?utf-8?B?OVcvNDAzSVo5d3MzUnp5NkpyTDZEY3VwNnh4dEtCamt3eTgzbm1NZlJpRmJl?=
 =?utf-8?B?UW1wak5GU3hiWkxuNWdTY1U0ZHVmUjh2NFQ4SFM3MVhlVlhhbVdjd3lDNVFN?=
 =?utf-8?B?dmxUM0E1UStFSTVldW4rYitaeFRXdXZ4emJSZ2pUVmtUd0hkMWFLcy9ZcldS?=
 =?utf-8?B?cGZ3bFFjdGtEc1ZqamJ4Q2Z4ekdBTjhUMlhzRXZGMUV6M3ZScE85WUVmVGtN?=
 =?utf-8?B?Mjl5OWhjRlpHbU00SExrZC9BblljSmNETVUvT0ZBSFNtRXlUL1A3YlNRdUlB?=
 =?utf-8?B?MDIxa1BHVUkvSjRFRDFmMGloWFZocXZranR2VG5pWDAxejNjV3lMbVBhYmVo?=
 =?utf-8?B?L291SWhzZFA0a1N5cmt1VmFkTnRuN0VINVNqTmhEYzVRMUJVbW9tRlpjZlM3?=
 =?utf-8?B?NDFtRDFFajFYNWM5WFIyTU9rYjBZSWVQSE92bjNCdXBWRURiMHNJd25pNUJh?=
 =?utf-8?B?TWtmZlhTZGhxVXJ2VnByRWN6OUtJSGp6TlZqTUwrRjBqaW5Gb3dYRWoxcmpH?=
 =?utf-8?B?SStwWDlmWmZiYVAvUVZwZ0RxYW9aOGZkK3BvdnU2MHJGYlhmYy81cmdZZ2pB?=
 =?utf-8?B?R1A1WHdLcEM2bXo2NXVQQ3JRUi9OVVYvdTFQVjVtWkhHR2paWEdDWFdONmJ0?=
 =?utf-8?B?QmNkSUgrS0E3U3d4NXArdzlua1NkTDcvMmpid24veGxaWDYzeDcrbTVJWlNz?=
 =?utf-8?B?MUNvZGg3TkZrQXRMSDY0RGI4aDR1RGV2ZVltUFVvSmFibWxjQjJKN0dNUCti?=
 =?utf-8?B?ejVFN1Y1S210VWZ6T05PUGs0ZHg2eGxkQlJESkpjZjlCT29HOFlzUFBRSjhj?=
 =?utf-8?B?aHlVNXBtNG1VbFptell4d0dkZS8ybzhYN2dwVjhLeGFlWHVPSzNYVW5tNHps?=
 =?utf-8?B?SnR4ZjA1Rlh2WDFPWW1SVHlkTFJXWmxUQjFzak1tNWdXWjVjdm9rMi9Sc0pG?=
 =?utf-8?B?VkU3aFNrUFlQRXMvSXM2Ym5tMWtMaXJ2R3VjR0NqejB1NjdEOGlRcVZONzhr?=
 =?utf-8?B?eThaTUNrdXFBbkx5SU9iVTFUZW54VXloMTFRNEJyV3B3ZE9SMDFTYVRmamxG?=
 =?utf-8?B?MHMzWjlTcXJkSVBiL3QycVREbUlDK0RnNTdDY1paVzBCOHlrQm5HL1dWYWov?=
 =?utf-8?B?Vm16NFI0TEx1a2ZPUlQySmpwb1k0OVQwUlVybFp1czZSdUdQQ3VTczNRTXdN?=
 =?utf-8?B?bmd0bjBWd2hLK21PVWxXak0rc0IyNWFtOE0wb2VlMFFqc3h1amRDVStrQ0pU?=
 =?utf-8?B?aGhNYUdXWnlXK091SkdiTTR1aU9oWkFadUFLOGtiQTgycnVQZEpDS3liaVhR?=
 =?utf-8?B?d2l3eVBJS3pMVVNlNDMvZUxKcWJVV0NYcUEwTTV0eVNHbmlZWGw2eXBkdkJq?=
 =?utf-8?B?Q1M0cWNmS1N1amQra1gybzE2SmhWaWZhRTV0WXdEWEtmVDE5V1pQWkZaNXk0?=
 =?utf-8?B?SFFTTEI2ZittMCs4TzFHVWNaV3RQMVphMXdhYW9DZVhnTnZEd1BlTWdKNHdn?=
 =?utf-8?B?cVFqYkZFK1h4QzVUZnBsdVRUQkoyQW4zb3FRSlF5dWlybVRHOE5wemtsY0ZS?=
 =?utf-8?B?UndnclA3ZlZjb25hS1BIa2NTZFAwM1IxaXR2bXlNaHJ1Mm9YSXhraTRwaG9n?=
 =?utf-8?B?anF3bVNkL1F4WUVGWDl1ZGtHN2t2MkcvanZMMkFURlNLLy9ZeHJHb3JWYXJR?=
 =?utf-8?B?TDAreGR0elE2SXZSSTdZN2czSXU5TFhGUWNFVUdNVVcra1ROUlhFZ3BtN1ZV?=
 =?utf-8?B?VDcvNEdzN0FRcWo3VDZrSm9UcTV0bmdrRlpEYVhzMW5lVm9yYXdzV3pWMXMz?=
 =?utf-8?Q?RGfwOik1l3s3juwPss?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84fbf9b-8f8f-457b-89e8-08debae7ed2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 05:30:41.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Meqx5qdQPdWlJP4rEeHfyb78nPbtkI7xJJPGrHJIBiYMrZVnl0ZPaNUL48DeVBLeKQ7R2HQEI9M/yC8Bx9DocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10889-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email,amd.com:dkim,BL4PR12MB9482.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 255355D0D8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UHVibGljDQoNCkhpDQoNClRoYW5rIHlvdSBNYW5pdmFubmFuIGZvciBwb2ludGluZyBvdXQgdGhl
IG1pc3NpbmcgdGFnLiBUaGUgJydkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnJyBpcyBhbHJlYWR5
IHBhcnQgb2YgdGhlIENDIGxpc3QuDQoNClRoYW5rIHlvdSBGcmFuayBMaSBmb3IgcmV2aWV3aW5n
IHRoZSBjb2RlLg0KDQpJIHdpbGwgdXBkYXRlIHRoZSB2MiBwYXRjaCBhbmQgZmxvYXQgZm9yIHJl
dmlldy4NCg0KUmVnYXJkcywNCkRldmVuZHJhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+DQo+IFNl
bnQ6IFN1bmRheSwgTWF5IDI0LCAyMDI2IDA4OjQ1DQo+IFRvOiBWZXJtYSwgRGV2ZW5kcmEgPERl
dmVuZHJhLlZlcm1hQGFtZC5jb20+DQo+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyB2a291bEBr
ZXJuZWwub3JnOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTaW1laywgTWljaGFsDQo+
IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZG1hZW5n
aW5lOiBkdy1lZG1hOiBSZW1vdmUNCj4gZHdfZWRtYV9hZGRfaXJxX21hc2soKQ0KPg0KPiBPbiBT
dW4sIE1heSAyNCwgMjAyNiBhdCAwODo0NDowMEFNICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gd3JvdGU6DQo+ID4gT24gVGh1LCBNYXkgMjEsIDIwMjYgYXQgMDM6MzY6NDBQTSArMDUzMCwg
RGV2ZW5kcmEgSyBWZXJtYSB3cm90ZToNCj4gPiA+IEZ1bmN0aW9uIGR3X2VkbWFfYWRkX2lycV9t
YXNrKCkgaXMgbm90IHVzZWQgYW55d2hlcmUuIFRoZSBvdXRwdXQgb2YNCj4gPiA+IHRoZSBmdW5j
dGlvbiBpcyBub3QgdXNlZCBoZW5jZSBpdCBpcyByZWR1bmRhbnQgYW5kIGNhbiBiZSByZW1vdmVk
DQo+ID4gPiBzYWZlbHkuDQo+ID4NCj4gPiBXaGVyZSBpcyB5b3VyIHMtby1iIHRhZz8NCj4gPg0K
Pg0KPiBBbHNvLCBpZiB5b3UgaGFkIHVzZWQgc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBvciBi
NCwgeW91IHdvdWxkJ3ZlIGFkZGVkDQo+ICdkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnICcgbGlz
dCB0byBDQy4NCj4NCj4gLSBNYW5pDQo+DQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+Cu
qeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

