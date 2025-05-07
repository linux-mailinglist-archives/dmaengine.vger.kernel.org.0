Return-Path: <dmaengine+bounces-5101-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C876AADC60
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213363BC477
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE85823DE;
	Wed,  7 May 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OB86zLc3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FE10E0;
	Wed,  7 May 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746613264; cv=fail; b=n58B7nA6bSuO4F9+Ayq3RzkDaS5OQyQ2IgIWniXFx1+K6Ml9J+l/hY/46MarzYv3STuE7vqx0l7zvaxSA8nASA7N26IpbEz9iqtuHPDCV9vf56N0n6pUmNi+6c3G3MbJaNATeoXUo1CW6hbzWgIM8Hbyv3gk+lWAqbHYBHVw8L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746613264; c=relaxed/simple;
	bh=+x5DJXxYppO/rXbOhgXa5AiOXzEIQfu6ds7chwCtpOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S3UujDjCpUtqmfccgsDZfmtM0Eqwuz/9QA9df9U5KMCigf9JKQErCNVaKJbnA7f4JA4hKZZ1sh1XH5Q1M6wLPfid2dJc4wBeiXE6ljfpKUtwxa+Vxvx9AMd4gep2iAd2MMdtKwWw0yPFnyGZRAAD0NGyCUDgvqy8FExgR8BufbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OB86zLc3; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D211I6zSAXf2vT+FJBQdR6r3RoFRsMeUYtKKLkrTuTx+jGaKM93ToS9qQDO8Ehkvn9Wuxs4j+rzvwCEXQDPoQHZCpexLWheROBgdsjw2gcNMuk4lXvlnJk6pX4z8FNABgEGuaLTsw2psrUQtSNRqVE9X62EYeb2Ers0dcOhlwoxySKQfKh3wgh2rgc0wZlCq9oKjPYxQ/DXO895/Q4o8zjECUjUdrc9MholpZUabhgYSbKM6FOmwLmpQ/pbcMgVVUkNMBcjVfJghw+cKmJZRHnL4765ctjLv3Ruo5mKR8WiUFGzfUYoWBqpVfQlCij1+VXVbJFDULR7XUQ0UCS6SYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtmrQ+or5YFdvTPmMe8IveMPSNWrIFHy00pXkt2sGg8=;
 b=XsFnbAs5okxylYK2qdgQ9x9mgiFEQoFidCQ2aW1/uhuOZW+ZFw39jiw0JCngKPJC/faZucEFF4vhIaJPBOfe1igJSNvh6/EDmyMJpAsqwsI1zy5/+955gELXoJdA8vJOK2Z8hcRblFf+QhT9W3L4mjJwF09yc/H5Bs8hFQL9J2Tl195zwdaDsMbDDFFoiLWZdslLkh2AOms8oMpvqZOP9tCvOYAzGpny6PyxIyrc0xN9G3hQwXqVakUvvLHz8uWXewHjNvUGFLKos9uMcIASEAuzmK4SaxtROL4x11H5yptQCLv/H8r9HopMSk08s6aFnJHjWNW00OERjBOyrGahqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtmrQ+or5YFdvTPmMe8IveMPSNWrIFHy00pXkt2sGg8=;
 b=OB86zLc3YzhoB78KteQw43Z8OyX6K27DH0AFEfGpUMTEG8r/OcRwxByT8zgAU8ZwBy0+DYEtRqjR1FYit8LqXj6DVimVUUDJmB8kpKbbU7V9xSwQXX5wKZH/PkNnFIAjOyN5tvTP1zEXFABC+ZvYybbE/4TLTY4Xb2QvTckY/8Q=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 10:20:52 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 10:20:51 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	Marek Vasut <marex@denx.de>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>,
	"Gupta, Suraj" <Suraj.Gupta2@amd.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Thread-Index: AQHblOfyPgreEFaTb06QsgCB79kDoLN25v/wgFBhYuA=
Date: Wed, 7 May 2025 10:20:51 +0000
Message-ID:
 <MN0PR12MB5953C8800220724906360D54B788A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de>
 <MN0PR12MB59531CAA16616476F2E09EFBB7DF2@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To:
 <MN0PR12MB59531CAA16616476F2E09EFBB7DF2@MN0PR12MB5953.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA1PR12MB7152:EE_
x-ms-office365-filtering-correlation-id: b0450782-9d4e-4fa3-a62a-08dd8d50d817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?k/N5KqSst/nqkcreF+rg4gOFNVv6ahOhDzUqBMTDQN6uceFYZHvAe3ih40?=
 =?iso-8859-1?Q?iYZON9FIYtVXbksnyXWQlshcgL8RPE7jvS0OIhVRlyu920ziis6/bcxYQo?=
 =?iso-8859-1?Q?aLh11DBZiXdyAL+EIZP71jeXqFWp3eH2UGA1uko8RJqfKblnzlG1YhxyhU?=
 =?iso-8859-1?Q?6LMcNO1rIgLEsagBV8XIIUETb3qICC8NFty9g1vuxu2DDdzVSfYicjlRSn?=
 =?iso-8859-1?Q?OdpNkmXNkYcQ8fu3KV5eqwMwHRwvD4p4klZSCoS1XKW/3rxsrjPE1PGTg4?=
 =?iso-8859-1?Q?dfVj1zDES6X3zmCBwDm2d+vjZpf9rGqll1IQ5NA20D+wt/SYstNkWTMnDe?=
 =?iso-8859-1?Q?hFsgf6Qh9ZJ72ddDEcTlfky+y7/HPvYrJClZ+5w0fNwc1WfQtYq3+sbRnN?=
 =?iso-8859-1?Q?ZbeCaFWIUAoZcvWMqzvOqo6yRBtD/v/xIy1VBIJN+OMi5/6MovlRemCOUp?=
 =?iso-8859-1?Q?+oca6fuy+lu2bO2CcaGhEKPQyS176aLsPtdKfP9a/cPMRdUcChojl9X7cM?=
 =?iso-8859-1?Q?afcCZt8yTgDDnERyYnJNgqoyLvFd6qXvhK24VnFK9c+1ONULr783R0Pzpa?=
 =?iso-8859-1?Q?0l7LZ+5FZHRZl1djKIg/n/yOUUhglRhjp4lbTdZCtqGpYW5/M+d6Qv8tzj?=
 =?iso-8859-1?Q?jAukBWP0tXcBBjWjOlIM8Z24GVh9swatSf6qgI0pzd0P/40q65SDuFfD4+?=
 =?iso-8859-1?Q?ceKjHslcN9+3pBZ2V5sKhNSEv8UAFh7kb0uSh5RsnBw97a1qfo4+R9hclR?=
 =?iso-8859-1?Q?r6Ez5HuvWqogASx3UVzWde173BNS4GpBT33Q+VjgXXnsQb04xIiuc2oFX+?=
 =?iso-8859-1?Q?zhRe34pXtSv0nyXjrmAjWtSClh51xvwnqILVqCOsrBr/w0roylSXhoUMi6?=
 =?iso-8859-1?Q?64DK3sIjJFHodN+TufwFEfVC+gmno9s8KCz31kv3ILacW+5xbZt5b84icQ?=
 =?iso-8859-1?Q?dyv0BWlERz2BRgRUVkXy35JgBBOmwOnakgRU5gGc4S3huRt7MhY5aWVmIL?=
 =?iso-8859-1?Q?yjtvxpjdEmr0TtI6WuUZEUvqFLEWK2nxAeFJu54fOO4m5QJVxRXLqj9H/O?=
 =?iso-8859-1?Q?ra/+8lJ8UlkGz7Rok6FZpH4+N9fANJJCYurNlk7brVNkwzwYiLLwY6yBu0?=
 =?iso-8859-1?Q?+9PZeE9YhNwUlUESc54E7NzmiJhWqXEBU35xTaikv0KQ3Bl8mZZEDAyHek?=
 =?iso-8859-1?Q?or8qakygFKwBqUv9w7mgWmt7o6psWgr8jRN2LRnT5p2oXLCx5p4a4Bgr4V?=
 =?iso-8859-1?Q?0GI3oXgB/K0VeezpnTN/EyjpfHKB/R5mz9nHCddnymeACS5ajxdqDFesHI?=
 =?iso-8859-1?Q?NzoTD90UUdIxd/ZjCoWtMqGJy9ZeHl4Z+oTDLnvqy5Ikyo9WX/8WAjn4EC?=
 =?iso-8859-1?Q?DwrvxXbTvj1cxl/UB/qFlDu0Q4yDcULapqzZxASwJW2lZyAl5VUEGKdGrv?=
 =?iso-8859-1?Q?ut8rNtKhQaqWoT2p13O4KR5JE4nWCe3UO3j9xf1FjUSgeqYHRUTcwyVUVB?=
 =?iso-8859-1?Q?+IgGzFYQIKe6Km1ZBd0ufZf61J1WyNJHwjWPTMvNGpkhr2F5KhHLcVI5JX?=
 =?iso-8859-1?Q?vaC2/ts=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8ThV7RNl1NBvJeu8qXX78fiFjTX6UXZTdrPn38DF+9od+ctVzFrF4AwQ1i?=
 =?iso-8859-1?Q?3y160O/q20+4X/W/HVFcUslNrNbJEcd9nZR0jNsWWZy6W+oW6EIXa+vfrH?=
 =?iso-8859-1?Q?GIf+mSnfBBbcF9YYNE/HLVq/9tfBP++E1tjvp90MIXlGRZAE1xDnVVfQyd?=
 =?iso-8859-1?Q?he3a5tiBJzw78o8y9VfzPPowB/R7dCYMsA3AiYiL5C2FS/roRDwY6AZ2pv?=
 =?iso-8859-1?Q?oU3oWQ+yQmYpG7W8fyfYnDMNNRiqtiPfr8llhwWDGDDMzpFmAUtBU3m5oH?=
 =?iso-8859-1?Q?/IpZd2GW/QmZo8/hFBoBU2wXXz83Yy9RqQFN/v1SfXDibQN1MWcQk/tksI?=
 =?iso-8859-1?Q?uOXiZCRkXiFDPyOBSRnyIo9elYJqRsDifUbmyoPBFLtUBdXzlWwYvjZvjr?=
 =?iso-8859-1?Q?PRuFjR48b4IIW8z3hC7NJ2Je0DofYijWWJ1CWMlRi0glm5RIrLI+BL9bnw?=
 =?iso-8859-1?Q?+9eEXIKXzDbzdSbKkPk/NmZ0pzCKDQoJcrrrFQPbjQRy6kQ1ho23YftiE4?=
 =?iso-8859-1?Q?ZUoXghyDW9HR8NzgoezGQkhtrPSSbvBynn8ngS/5IsVtLLauY8nqj4XI9v?=
 =?iso-8859-1?Q?2vRyOM5DHIeJA9TxeCFArnpeIurfGm3/SHeIC+9NZcsqpnfBmwTy/x6ei7?=
 =?iso-8859-1?Q?GA0k8visLQWgODcPJkP+919wnEybz4ZkhZ7xQMQnmmF7OtG9Kce35nVOEn?=
 =?iso-8859-1?Q?UCm7yrV3xVhedT58a2X/o1qmAy1RIdZvVTTTvQybmjljF7qhNMfjo+JhKl?=
 =?iso-8859-1?Q?N/x5WrYfp8RH6f6nvOTt8DL7Yx4Z52ssUv46CaWb6rBY8q7oaETHIbXTXJ?=
 =?iso-8859-1?Q?8WW5lS1P2RDwu0fKldYtRM3R4CV+baujnVF0PBBAKer8id4vC++jhh7ZJ7?=
 =?iso-8859-1?Q?2qh/AHVxa7/mjN73AJ2IhrPOyTtQzeNWDZDyLEJITdGpytnUve6ITzaLDz?=
 =?iso-8859-1?Q?bUDFYDmq0fGh1SSNx6S7KI0S/PyaaVaGPKNw+LcoXitZu2lNlyrUx6x4ns?=
 =?iso-8859-1?Q?UVonnh3CCh8gXCiORoCuKmjXvaZ0pWJbLmAhq4ch9Yh1P6nOU+11C21+8n?=
 =?iso-8859-1?Q?bsr4nREjaAmYIvQn/6dmP3I+615Tqb6XBTnUt0VROo40QycNsPE8tw/zRJ?=
 =?iso-8859-1?Q?iJcVB47rkD63e39Gw3u4ojM6JSKBDbDzlR7FbOyEB97JOBjFU8mW6INQBa?=
 =?iso-8859-1?Q?WhZTGMVtEm8OBvHC9pCPEs8IbMzmWMyI9WFBJvM6grlc1hXT0BzTtd4p95?=
 =?iso-8859-1?Q?8Wd0womqhmmxP+glrhZ+zchIod6eqkLsisWSckMgiOWLTdVo5gXauxW0I8?=
 =?iso-8859-1?Q?YGpAm9t/wUAERq4HK/YBvyxGxpD/LWk9rXgJAe87e3NgsoVxN2rlhoFkoU?=
 =?iso-8859-1?Q?XPd2vPnMpm1dJt2bom6Bj1ltDr/NtfOEkQImlEZM85t7HtNI9Ykq+D620P?=
 =?iso-8859-1?Q?cTR8ogr2lj4DUjf4A3EnrsjMmdOaWmoYzYXgdPfi3c6k0fNE8DIAJ8PiJW?=
 =?iso-8859-1?Q?r4Yw+aLQohzdvlG1VVkA47VxSBLlz5d+p+SKSlr5d8ROo1j9tjmjwG5s4d?=
 =?iso-8859-1?Q?nbmyPIE2+qYURyaU7gYORjrUb74SPPyHVnd1vZk1Ib5uq2TItO1AtauJAU?=
 =?iso-8859-1?Q?Ah9ViwA9xJHBU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0450782-9d4e-4fa3-a62a-08dd8d50d817
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 10:20:51.8429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfVEAokHo63uq+vzUomEkTogVMY7aJrS77l4AamcUjKOfUwk5rXFKjfrRffr3LPq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pandey, Radhey Shyam
> Sent: Monday, March 17, 2025 12:18 PM
> To: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>;
> dmaengine@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>; Simek, Michal <michal.simek@amd.com>;
> Marek Vasut <marex@denx.de>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@baylibre.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>
> Subject: RE: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
>
> > -----Original Message-----
> > From: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
> > Sent: Friday, March 14, 2025 7:19 PM
> > To: dmaengine@vger.kernel.org
> > Cc: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>; Vinod Koul
> > <vkoul@kernel.org>; Simek, Michal <michal.simek@amd.com>; Marek Vasut
> > <marex@denx.de>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>;
> > Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
> >
> > Coalesce the direction bits from the enabled TX and/or RX channels
> > into the directions bit mask of dma_device. Without this mask set,
> > dma_get_slave_caps() in the DMAEngine fails, which prevents the driver
> > from being used with an IIO DMAEngine buffer.
> >
> > Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Thanks!
>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index 108a7287f4cd..641aaf0c0f1c
> > 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -3205,6 +3205,10 @@ static int xilinx_dma_probe(struct
> > platform_device
> > *pdev)
> >             }
> >     }
> >
> > +   for (i =3D 0; i < xdev->dma_config->max_channels; i++)
> > +           if (xdev->chan[i])
> > +                   xdev->common.directions |=3D xdev->chan[i]->directi=
on;
> > +

Suraj also worked on this patch internally and he did set direction in chan=
_probe().
So, I think we can switch to below implementation ?

--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2909,6 +2909,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_de=
vice *xdev,
                return -EINVAL;
        }

+       xdev->common.directions |=3D chan->direction;


> >     if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA) {
> >             for (i =3D 0; i < xdev->dma_config->max_channels; i++)
> >                     if (xdev->chan[i])
> > --
> > 2.43.0


