Return-Path: <dmaengine+bounces-7652-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E44CC1EEB
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 11:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E327D302C4D0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009AF325736;
	Tue, 16 Dec 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qQ+D9/AG"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1BB338F38;
	Tue, 16 Dec 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880137; cv=fail; b=LVrj9nvjxGsvMsLHnGd2e9uQvefKK7ytB0tl3Pe6QvHUWvis9ofVFEqzi7aBi8kJrBSycYhYS4u/HxLqtassWfchCfIZvV1ctTGe6S0dGJM3qgW2lp6lRtFd0rmt6dgAP9pYBtpu7RPjhlJJ61FviKF3n0ZsrWC1omqhkT8qky4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880137; c=relaxed/simple;
	bh=eiEHu0gpHqv9Wq/XTq+nysZdeHbt94aiffF9nV6wUpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F+/ZDuyV3kyr/qS9HV8LlyF0nU77iznfGDS9WFyqBEUuSv0fByaKQk42QGo9JlKrxB6x9VgkXCi9Pp8uES48WeGZ7nez1Mx88qShE2wc2K3dOE7GMvRrBapGk564TCD3e7x1xYKE23+vk7JrZ4WdnDfY/zxemJBeRNU6zXg0Aos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qQ+D9/AG; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlL7kvuHBN2sjVxY0V4maQk+2Q/4b03OGljTspm6qimnP35nGNAGzaIAp4N1l++kCVqSYUugmGQnYAMsVajyPl5XjzM8VFG+hi1WCEp6HA/DkR/i6ap9bYZlTA2vjrRP9A3Vs9iZ7lf58dgcrT3jpt8CdDk+aZEI9oEKrix+trmzzxkvtmJ67Y6wSwL+8wzloRhLTH9tHA5tRNlm/XUopNqrKSMbwjFEu4UgOi2uOuwP4PLMq4MKLlKS9ezHjSk7TUsjyI+kXia6OygGq8f88zytkP09oc1/ik5bPWf5+zitV28A/SbwyY1Orq5a0fC4fDFooTYEBksQaNvdb19Tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRrTRviCKiPB0Z73bCNOfEIrtn+5hU3naKfCivaTuBY=;
 b=ORW8vm3Xc2o89w8ujkdWhuq9W0MNNk5dCU9gpKnALCs9an7zItSC+QdHEBQDPqP23ieonjbhQYxcj5ay1K3yC0iViDK8R5d+9knbTl6NLJgD34y9P3RpgRTSu+V56yR3UfRUBcg+DMlyLJUlSEwnA88TAOXLb5UM1RGfTYu1BmYw2+VTFGWONpYWgEBUt+c3WDqvGcD55zkH3BTpiFsoRxo3UwjhBYN1nqyAsS1amG58rckrB+dT3YlRGLHwtTG5PefHjhmP1m9G7DCie5QytmNCkj+b4kSUJUDX2VuZsjryLGL1dS2pbfPB3+uK/dOSBPCluSUUBNwVXok4nQ3qWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRrTRviCKiPB0Z73bCNOfEIrtn+5hU3naKfCivaTuBY=;
 b=qQ+D9/AGF9tSHUQ+7NKtl8Snu2ZIlhjG/7OzHG02pR+j+VidVK9g5gJ4QsmqQQKlBSe1Ew/SyX1p4ralX/frhy5JTqZQ38nYpecOrFlo9e4753oMaoqmxYlOvp8fPaiZg47fA58q+g3gMqK2Z+iAkUhkC8O0vjHxmVPUsEWQA5s=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 16 Dec
 2025 10:15:34 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 10:15:34 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHca2HPzgtqx97sLEy+fRS/FbbYFLUeUYsAgAV6cSA=
Date: Tue, 16 Dec 2025 10:15:34 +0000
Message-ID:
 <SA1PR12MB8120306AAE9B655A8F8273B795AAA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251212122056.8153-3-devendra.verma@amd.com>
 <20251212182138.GA3649445@bhelgaas>
In-Reply-To: <20251212182138.GA3649445@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-16T06:01:10.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|CH8PR12MB9741:EE_
x-ms-office365-filtering-correlation-id: c175f6ff-5f46-4a3b-e109-08de3c8c0cfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QRKRl/6iOk0Dmz2ZIEyf9CxdPG1AqUqr1RM+2WjlnzxszW0gUorbbzzcq4iB?=
 =?us-ascii?Q?c3IfQkVc89Kwh8DRqcsHD+xTJ8RN5BhQ4snedb/4Lq3dkBin7Z+CeUHnzMOL?=
 =?us-ascii?Q?j/E3n9m9lTZWm0Oe0PSFcTwkbfCSAnDuLWTZni9ypAQ93ufxEJXqSYrrKxfL?=
 =?us-ascii?Q?z71naQ/ap8XGOTSIJKHrR268JQAkFW++MSZkjWBPmyobangQ9UduK7kqEjGL?=
 =?us-ascii?Q?RNPeG+S5qRaJdrZG1Bzas3zfA/0XPpUsJOBKeYpzgFNLtUSw/EcuUPZZaSSQ?=
 =?us-ascii?Q?Z2YHLxKbqvvgX/XxGtL2K4AwnLWUSh3J/uIh4ZlRBf8AY8dqtHRqwTjWH+ao?=
 =?us-ascii?Q?1IZs+IzAIF+wZ9WOqa5OVnHsmAbynFyNV8fV3wElvSWXwwygzwRctST5CrVN?=
 =?us-ascii?Q?ChaAjMipHNZMhuQVoVYSdWAlq0bR+plYoEFF/huN+eOG5jjRTG5v2vox/cCl?=
 =?us-ascii?Q?XSfyFKyiAI1UZpKU3tEqtnxp38Bg39VJENnwcHL0gwBytHxMyttPP87GYUCB?=
 =?us-ascii?Q?Ui2XQw8PP1FOOeSOh+YW2KZd8kpNQ1VlMuKSK/BrFR+PuhDlCC9S4ICP94+6?=
 =?us-ascii?Q?d6kt3kBhhs7d53eiTmEEzOByyFO6CMz4TxXPd7E5EXXoWYNv5NmHv5qy1xXf?=
 =?us-ascii?Q?+zQHiW28W4AULmtvAWiMg8OELVcXU7OyqUfOdFil+r29EbEpWeJfnKeX9Am/?=
 =?us-ascii?Q?sY+I2vUE/kFI93cwL+n9xeKokmjkrppKW7Xi6R5/0X23mw9EZF6H20CMgfn/?=
 =?us-ascii?Q?3f10a0N85C+gtBD+GlCwFqn305a18se2xQKfS2skLGhYj1GSErcmlxeNQkEh?=
 =?us-ascii?Q?XkjNV+NoZGwr6xQj2ZngkOtpX6nVSY0Tm2mjzuR8+VZ0kGywHN2ayc5q3xm5?=
 =?us-ascii?Q?OkbNfqUk65PL0z0w6kaSuFASDULCKmEsR4oIf/tRyuEL4rRrRB0fZ558on38?=
 =?us-ascii?Q?qFAPmYELgKPopcaIC3mtNT/i6xp4P1/49Jkq2DEC+TPQh7pmNXDbmyEoXjyO?=
 =?us-ascii?Q?B8Ts3z5ZxqfS07GB8Wt20hJBVQSDlt9BNWlSr7xwvLquyndbiiyqitzqiSlY?=
 =?us-ascii?Q?nHNRoAtDoZ0wr/enMiFbD3sKMtwxAve0PoCeV7hTz7FbPFb5+JhXjv4asC0t?=
 =?us-ascii?Q?oZ6jrmLs/IfxtgG2fzwnIzxCVggvekn/1zAhWPrKvXOoUcwU1RaAEtoJdvVr?=
 =?us-ascii?Q?1f2c8jxHMnczIwG4STlGvF1mUaLvcvWyB+xiV16906cCkPN2xd/T3vZyQXEL?=
 =?us-ascii?Q?ZsueOoYEjL5Q2NogUar5QJv5lo+kdaz0R1uc6aUOwE28kj0Ga9a/0hJ/3xe2?=
 =?us-ascii?Q?N9rh2vWH9PZfYCF5A6V1SjmV2GE5wpsV/GEd0j1z9ntXPfs/FGqxkbEQAZ9T?=
 =?us-ascii?Q?49HCHDX5Kfl6yL9spX0UDAFX4bdkKvkawOBiAOTJy+9sbyNazQm511UfphxV?=
 =?us-ascii?Q?6hA9o3/5a4iDMX+6Z+iJDE3uZkKPl4LVP1wZoDq1WqdnNnNtNgqVttxTvJQN?=
 =?us-ascii?Q?vcQzTdi5bL3rqJIfKxDULqtkUX6y3MuK4Jeg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7fyB2ikSjG/bWUv6EaX5LdK8bZBKRnik1h2dWJ/149qdNgPFYFzGYHlQwyY0?=
 =?us-ascii?Q?B+Cw5ZBQC1fMA8JB36Me2WERnVZeV36tZQvzbjFZtEbq3+3TdhKdfUPSUGh4?=
 =?us-ascii?Q?3/Y/pLWeFKD8x4jJ3v9GhQLSYWll30dbM4HZUPIq1ELW7zfE5VlcLtZ4+VHm?=
 =?us-ascii?Q?7fx9iU2757Hsth0k3TZ0VP0blYrxp2sWMtuUNCxZ/uZ+da1pXia5KJLo83Dc?=
 =?us-ascii?Q?EgZsoAmpYDKAbua2ppyF7TwMl74MB2xLe2SuwsbGYTCv+veOCpw/w14YpICD?=
 =?us-ascii?Q?wIZe99uTacECHTEuj3MjRi3cPXe8259inCS6IVMZOPsJ81fzQYox4nzXeVs7?=
 =?us-ascii?Q?icJ3B0vUDfXdYnHJ4HzJnYmhYlRMrJqB6KgO19U2w+KS2iGtcCkM1ODBiQsf?=
 =?us-ascii?Q?zEvg0UPynuiJsLZJH2X9sBsw0wBtFcUFsRZ/5s3WwKLtBKzOC8uY5hmCnKWZ?=
 =?us-ascii?Q?UrMYs+IZfGfPh9fy0W3Jtk5SfllWcQOAj8byNRRbumnalIFtknCte90IsyaV?=
 =?us-ascii?Q?AbjwvemymjIou1M40AUIbvs1EnNiAj+g4srYrlzfOqAfDulp7+nsc1552IiK?=
 =?us-ascii?Q?v/TllA1HMQEF+xdt7mIb2gKmFBFYnSeIAeSeAyAUT91qiEfoDQ3egXg/zLnr?=
 =?us-ascii?Q?gYKhCt1Ik2+BUbSx3ndI6bUtO7fJYcJAWDGa1byYuE66TiHY+XGOrr4rGeEq?=
 =?us-ascii?Q?1EPMsFGhHpXgk/wrlEcbUt4eG2eu1M/6uPIDYRflHVUcbwXp8mI72/NdzkA/?=
 =?us-ascii?Q?xlN8hkJQ8oIdn21kut3qi0XTf3fIOiWw2aVvRoqdG//54f/m76Kumndnrdfw?=
 =?us-ascii?Q?ybvMdtHv/fSD8BTkSKNFzaNpeRIPAlco2qpBQjBT8XUMs5DLzkYJeNW30KcH?=
 =?us-ascii?Q?VnY1EgDNHx/xRfOT3u6upPsTIKwzjvEJhwC12Q7OYL4jRtyNcRp1pgNcIxX2?=
 =?us-ascii?Q?06OBUjDcNCqDU+9Vl/dtK8YkqtUpc6hwFkEWjYhEgpCey3B0cc0WGQmiKdWA?=
 =?us-ascii?Q?xoeV1QrUt9+fF6H8mQiPts/1Vj19ZQ+YNdyOlc5Iqf/1rfPI7/s4esLzw07H?=
 =?us-ascii?Q?yEeXC041dXRBgMBHrEbA4cC2pXpv8HRiGsm/vTfSf5oMgLTsgD3PYffttwKV?=
 =?us-ascii?Q?Ba++pIBJLfI2t7HU0C0sASV091JLTCDSdCFGX1TYrkWHg2Dacs109kvjyvSr?=
 =?us-ascii?Q?DHWo3EX0JSw6XI3hqRP1T9ArDbyYxCDe4OvLgDdwYiwxOCS/GEEgTYLmZxPA?=
 =?us-ascii?Q?9EWK3are5nehCShFw5AHQ7C+s8qKKGlQrQLcqOGQbm2/t/NNTbWh8vlrGOlL?=
 =?us-ascii?Q?KX3OWYhzTt3j5nCrEbabTUc2Ml/36aPdbtToIFDW1uBi/Zm/Ot0U5lwUaS24?=
 =?us-ascii?Q?qOVMCGRe6/wf64c+42oJH83WibKt5aabUM8wEZi4daqtIP+PJy1GuV/WVdpq?=
 =?us-ascii?Q?BC5QSvElP1VHhK4JJoA9cPhWPyW2j6Zh1a+0p7O3AcBPTT9exgBXU3kYmCAN?=
 =?us-ascii?Q?IIM3hsEI4IjTIlRx+FvZBbGCY2fams9bDDVykMPU3h6BY8AHZCB+d9vn6Oa0?=
 =?us-ascii?Q?pnewYwO1WU8h9s9RktI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c175f6ff-5f46-4a3b-e109-08de3c8c0cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 10:15:34.3763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/o38qpwA6uhCxxO5WDQDkE/IE6yT+iaPIDI6fGChGmvCs8qi2gSvPFuhI9L6ZfewthEU8ZXJeW3vOS45G50IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, December 12, 2025 11:52 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Dec 12, 2025 at 05:50:56PM +0530, Devendra K Verma wrote:
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
> > ...
>
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct
> dma_chan *dchan,
> >                                struct dma_slave_config *config)  {
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > +     int non_ll =3D 0;
>
> Other "non_ll" uses below are bool, so a little bit of an int/bool mix.
>
> The name also leads to a lot of double negative use ("!non_ll", etc), whi=
ch is
> hard to read.  I suppose "non-LL" corresponds to some spec language, but =
it
> would be nice if we could avoid some of the negation by testing for "ll_m=
ode"
> or calling the other mode "single_burst" or similar.
>

Yes, non-LL is being referred in the Synosys databook extensively to differ=
entiate
between LL and non-LL mode.
I agree with the concern raised here but, at the moment, this is the only s=
uitable
term that can handle the following cases:
1) Choice of variable of the DMA client to use non-LL mode,
2) Establish flow for the non-LL use-case in the driver.

Before, using the term with negation (non_ll), the possibility was explored
to use a term which does not result in double negation, eg, ll or ll_mode.
But this again breaks the above either one or both use-cases.
If using ll_mode as a variable, then with this, DMA client shall
either provide ll_mode=3Dfalse or non_ll=3Dtrue.

When ll_mode=3Dfalse. This option would be as good as
passing a valid reference to peripheral_config pointer as
the value of ll_mode would never be used for ll_mode=3Dtrue
due to default mode being LL.
On the basis of ll_mode=3Dtrue, the DMA client given option, no code
is impacted with these patches.

When DMA client gives non_ll=3Dtrue; this causes confusion,
DMA client does right but internally ll_mode as a variable is set
to establish the flow for non-LL mode. The different variable is
used for establishing the non-LL mode inside the driver code.
Also, it uses the combination of double negation variable.

Though, the use of non_ll, raises concern due to double
negation but its use fits the use-case from both DMA client
and in the driver to establish the non-LL flow. Additionally,
The use of non_ll also aligns with the documentation of the
vendor making it easier to follow.
Please let me know your thoughts on this.

> > +      * When there is no valid LLP base address available then the def=
ault
> > +      * DMA ops will use the non-LL mode.
> > +      * Cases where LL mode is enabled and client wants to use the non=
-LL
> > +      * mode then also client can do so via providing the peripheral_c=
onfig
> > +      * param.
>
> Add blank line between paragraphs.

Sure, will take care of this.

Regards,
Devendra

