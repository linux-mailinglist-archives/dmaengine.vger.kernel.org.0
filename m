Return-Path: <dmaengine+bounces-6508-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB114B5773F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 12:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB7016734C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7314B2F998B;
	Mon, 15 Sep 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="keOO/Xt3"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD238DDB;
	Mon, 15 Sep 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933681; cv=fail; b=lH92YCs5BufOSR9ykSmOORRajjuX2Di3cba790KH6z7Va9UzXDCNscMlr2BLS0Zb+87vf8jg6C3tm3u5ZTs2OO5LkIR1RD17QC8yj6WDIQVtpDCV3mi2nPq/FfEIECuBy7FG7b1mEx4tLwTTrF3CEllNidTlqpHcpVzFvtdD3cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933681; c=relaxed/simple;
	bh=lBKteziOaUDzAHJVHgx2M8KPZLSH0QIu/KaO2sGcWUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zgfk/RhLK4XU4CRNnTB4VV5pjjqbimMahIcN3Q+duccVoT/AqL/GYXU+S/zeypMm9Qtc1JfMeyQof0s0gI+jlsQCTDNGuQZimieiXd9YfMz/CV/JBeG2Qen4RSPf8drl7gCFgEgfW7IlHBMLrQRU3GkjgS9qCpFJdmjfIHwdPGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=keOO/Xt3; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arjSnmJ1gd68mSJXe22gp6T9WP6wKN76nLy9KvUcC+UoIrXTUvyVObKgHz+IXBFlOzh77McMnkfiVVgWsxomrENUNsKvezdQVr5UKMY7jnWA7qdyK2tLH/KYrl7p3x22S4VyFcEl1P6QZEexraYCaWnxHpEXRT3fMkoXOsZVaVXvw6hItcZNVAeY34e1qCOmZwD076Pwf6Hki621lnEqZ8Ra5Qeq8xB1bi4wLgvK1Yfc4TAQAGIsEyAqnPmZrXKKKoxdPhGEoWxnUVJd2XqoSQyLGo08co3GfyLRLEqVyQUkUowo7yzbxSGwNcC5OBi6IXwWWt6sclMLQ65L1kxcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6+DIdhlEyIN38IQdwUUxLe1vQKEppSosfIeLGu33P0=;
 b=mZbtTFBW3MfR4rOdSC5ohbzSG6rb6vd/jMtgwOH2bVfyaBJ0N5ST7P9iUJ5Gf3sdR1OcrfZY3moegz1FhREDeNSZqCbtB1MxbGC6AKRv0tuUvyB2kaAE9AyyuNmw5amEju2bus8uDNOmeFNzQeFleOiHvWP98+u/t4e+Bs55vtV1GGt/+vXcdGLz/MKi69eqSDPSUvAp3gBELVhpeP7KFnsyCHIWiudaaKIWUpBM8glbVC0XO13deWIy4Nlm+RIh9zu4f0kq0GSXdhV1QZEK+Tc/EsU4ujNEdk4XZ+dy8fPaZI4S3LAfOHrFyXSfXWnx4nnb4RjSA7IM+HTfHw0QaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6+DIdhlEyIN38IQdwUUxLe1vQKEppSosfIeLGu33P0=;
 b=keOO/Xt30Jh8AYuAt4ejjrryqpVGr8HjPCGxKWW/SQsPtkHTZdgC4SqVZrUzv//5gf6+2PUOpz8a1rtqC1fQObUE0lWnx4A8eOj6PuJ5lVXRvdshMEkfiFuY7mbXqdGo+6qu8QtlK28vTkdI+sytU+q3FxxkMHOVq9RVbXHl0Aw=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 10:54:36 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:54:36 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcI2aRkcXSEDz8T0WQWVSYvwF0+bSPSTZQgABlTACABGAZgA==
Date: Mon, 15 Sep 2025 10:54:36 +0000
Message-ID:
 <SA1PR12MB812055A34EC34AAA83306C989515A@SA1PR12MB8120.namprd12.prod.outlook.com>
References:
 <SA1PR12MB8120288197801A3F6C41993A9508A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <20250912153358.GA1625522@bhelgaas>
In-Reply-To: <20250912153358.GA1625522@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-15T10:22:57.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|SJ2PR12MB7822:EE_
x-ms-office365-filtering-correlation-id: e2c4a3cb-dfbe-4ef3-3d59-08ddf44642d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ds0wxXkw8f4sLLaKZb93bQns2IuDdzLyTbTSupmXRs+4S4pxEWFflKJ10yDh?=
 =?us-ascii?Q?i98ogap7pgWpjgR2O2mlJS2RnPe+oOyTj2EwzBJsJGvYgdZVVoeX2H9RqSbA?=
 =?us-ascii?Q?VaSv4d8nPLs8xkck/NZN0MlGkt34LmwGMsPMgKQiBJqIW50ffoWoF5B1GnnP?=
 =?us-ascii?Q?QZOAU2T7/H+QzT2EPJVpQv8wwcUw9xYAac4vHXI9pZ0PWieavjQbZA6vfHk0?=
 =?us-ascii?Q?HTXIWJTskrH6LzuEye6lvDwW6TMJZKYZPlqajesU2fwOiKJXIVNvGvVsPsrv?=
 =?us-ascii?Q?hRBrwFSFxXHXm1yQAODhFNgU1EYHJV46NXH0uoczKl2ianElmcp6XGfsHNG8?=
 =?us-ascii?Q?cIbFkmLaeVPpzkXfVjeDqS/hIOM+5jaa1tiTIqO8fkF3yopOWw6rW6fZ4Jxr?=
 =?us-ascii?Q?SRDlW5Wh4XmiUQfTp7h/IwebqP0TgfjYh1kjLoBJ+b/OAYdnVKLHbnZ6TLVA?=
 =?us-ascii?Q?BlrcC6mMMyGW57s84fjlzx5CD5E7hOj0NZwJ3CDFlZN8dL+LJYd7z1zeghDV?=
 =?us-ascii?Q?QWJ1jGLU/2KmXFgOZ6Cd7jwB6Jvvq4LXhvmM9GmajSu7zmwPOSBZil5dZmda?=
 =?us-ascii?Q?hMviq9JUBcDiprr9iGCLxGKtvzDLhrQ+MsKuICZSNZsU7ID496568kM07G41?=
 =?us-ascii?Q?bQqkbzwOGCnKMyYftO8WYh3r/7JcMDIYttZiY/k60NocI6kR6wnnrXJxdY0T?=
 =?us-ascii?Q?6kqWyW6dRoYSkdVsIXt0sNDdwqdrhAO+Piu4g4zClTwYPEMRfHdMsI91Xalp?=
 =?us-ascii?Q?Mx0aHLrf61mNuAn9fz31vg5ANxyPGQb1OJFoSWoOtNCkTNZ1DznByvFr85ai?=
 =?us-ascii?Q?JAc76Yvl89ziC89hBAIvkeYqTNa4QDpTNaJ4Ndcz3tjbq9tKOEM3PpzhLeKI?=
 =?us-ascii?Q?mFRanCh79U3FZUhAp3XiHDI44L/4Nupl1r+QFca17ZuDhQ+ZeTnS0So2a9zH?=
 =?us-ascii?Q?yP07fYPU0ndRvdqKc/eLpR+qCFAAq6UDZHUZdTud2TLYxXlNZACPKuiTrRuC?=
 =?us-ascii?Q?Ae/UwClQi2kul2VPZf3/2ggrAbTNoB0zIMHh9y+gZ5u/MVF6aDcwNoFUMImV?=
 =?us-ascii?Q?FUCgT6RGhjyzIb+vQVTjX2d3361qgOk+xy27kMqw5qsKRu8Ls7HFzi4qcSuf?=
 =?us-ascii?Q?HEwgiLcCsULBiZYVK13bG8ZkMFB/8Hp6NzxTlYZ/kCRqtmvrRBwgjMiXV7Fs?=
 =?us-ascii?Q?IXPuE+87NFODYrVRgxUtD9tNtLIW61G63bECIr9MurqiEDFKDHZX4DKhmjX8?=
 =?us-ascii?Q?kVuLySEvbD3X9ZSPSfv1oXw/L9liztO9ON+MuhsPUQl9+uG/kMRlazqvLuEr?=
 =?us-ascii?Q?IlbkQ27IhRYjYJFmLb9VFbeBGVpjrBOjvGzBi9VOLIFze5IcshGVumscvPYL?=
 =?us-ascii?Q?olp9JawyGQ7Vy84E/KnAP81ukr7yIzqo70GBPfcM0k1uUxR2hQecvXKZJ/LS?=
 =?us-ascii?Q?byWgQyVq3n9zZEDY1Z2TdqMzDm7FLr3r3bpdGW0l/lRh/hYQSTqa9Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jq3qTUJ/raB4yApHk45LWsLyEVGI9WG4GxYtxOyJy6+crS5s/FxISAadO/Ru?=
 =?us-ascii?Q?Y3Ad2tx245jknVUCHBiNOHlz1rBSF/aGMflAJbZzWxESyuhJv/Y2C+olRPK/?=
 =?us-ascii?Q?pu3TO9C0UkhQus2OVJwNLw1ZXS6nVCJiOwTe+ZxYckaB6vxcHLYH5KUiAo8J?=
 =?us-ascii?Q?hjK7gT3F/GT82mA1XFkbpkE2ZpsZxVG39UdlDRYTnaRphzg+ZAoM5v0KU3gq?=
 =?us-ascii?Q?x0o/IQNG7zMLSyW1yRpTSMQLnXeDCW+Au1VqW4wNWe1KER7rc4JuQUBnbJpc?=
 =?us-ascii?Q?oYIRXjZl43ME4D0sEs97aCo3tGbUCEYpJI6adbC2XdaxwHnfuTOBd2WUTiP5?=
 =?us-ascii?Q?2k6vGiLuPl+6K2AUBsmh4nXx3VmvNfiNzOCkTswkguuwDoAYT9RnNrt0sxgv?=
 =?us-ascii?Q?awQtTRL5s0QHKrdHcpjTmrsNdJo2jBi8LjxxWePaF8u/95VSGY69YVN5Pk9B?=
 =?us-ascii?Q?cXNH1984v/1t+ybi77AzIv8CfPDA3rIQx4GoxUEtK8osSgcrLMOtjbFRJpPn?=
 =?us-ascii?Q?vcLR69tToGiBiTB3hdBVCTtuGiutHpGu4VV8jdUOuWId9qvBPWFJ4UtdXaa6?=
 =?us-ascii?Q?1JtjxRqUJq3t7dciJeRXywhAf/nFlcrJ7wtn0vdma39b/deM4iCSkwQF2b+h?=
 =?us-ascii?Q?92e3tkiUIip3xijrcivFuBpfETXvcPQki6DAFsBkifR/o9+rTuAw34yx5TtF?=
 =?us-ascii?Q?MgI1fiIHxjROnCqvTCo3nHLrBXQz937YtDsOMUi/LVeffluaNwbZWzHFd64l?=
 =?us-ascii?Q?VwEGT8nviF3JvvS4+E3VKBey6Os3vzYeBBEMljuRPH05pewETS5feTvrDLUi?=
 =?us-ascii?Q?FuUtHPVJSQQAmxUh2UA1VshwcIBnurE1y1D8d9S6Py+qoyysM3VHJvJ1OmgL?=
 =?us-ascii?Q?zLMJWp0jqswLRjWYY2nuCLefqlHiDn0tjeo4gXw1qccUkAgWXQLpq7t8mm2P?=
 =?us-ascii?Q?rza+4jWiLir6TGELX9RbgeZiXBXwB060TSEA2goEW88/cHCBxALIcnC0Y/fS?=
 =?us-ascii?Q?/hsCPaSv02dx2GSi0jhOy3ARKQOnrQiKr4Rg8S/5dN2t0adOnsKveBWcMTVJ?=
 =?us-ascii?Q?hEOoR9PB6wTSL6KUNZzGVQOQ6PATo/J88F4/hX5G0n4BTeUPrb5A6j0iKj38?=
 =?us-ascii?Q?8TOdHkeE44HliLmsb/LHT35oBASxP1oMIHL+8st/ROEs8D5m5i1Q+oL6JMGt?=
 =?us-ascii?Q?euug4mikKy6dVkJ4Ha7Oq9nAPuNDiPhMfLYp3yo7Qcgk/qXsE1Lh983YRFM3?=
 =?us-ascii?Q?2V2GIVuAkgGoJwT88PaKJlxyYBCaKws1wl3PoTZjImdFAucEKn9iLK0L+HSq?=
 =?us-ascii?Q?uhMHL319MOmF9/jq/lgTbL/tH/dm42BQpOFZzKy8u2Ixge+FNiccO11GdaF8?=
 =?us-ascii?Q?rJXGAExJmfGtQuNgqbwwy+l/RHzXBlWk5MO32147Hp58o7s4V2ANQJ7C2NuC?=
 =?us-ascii?Q?Eji+obWL+98EkzI2RM/Ve7qgSxB0S+fasC1L0Oxt/aEq0kjQ3CP2m5Ijszt2?=
 =?us-ascii?Q?FA6eXc2AhcOUUoftwnT1vinz6zDwlV7R4UMctiffQBc/qZ1lngFUFzC+VQGy?=
 =?us-ascii?Q?4UZVCDpKDTC8l9vuvkM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c4a3cb-dfbe-4ef3-3d59-08ddf44642d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 10:54:36.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3l0FIdQ3/8mUgSVN/0xfsL3txNTdartTtXd08UJ0LwFSUtW1CNmy4xXzNt1qXFAg9mo9wq2jXATZHRQZSSVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn

Please check my response inline.
Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, September 12, 2025 21:04
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Fri, Sep 12, 2025 at 09:35:56AM +0000, Verma, Devendra wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
>
> [redundant headers removed]
>
> > > On Thu, Sep 11, 2025 at 05:14:51PM +0530, Devendra K Verma wrote:
> > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > The current code does not have the mechanisms to enable the DMA
> > > > transactions using the non-LL mode. The following two cases are
> > > > added with this patch:
> > > > - When a valid physical base address is not configured via the
> > > >   Xilinx VSEC capability then the IP can still be used in non-LL
> > > >   mode. The default mode for all the DMA transactions and for all
> > > >   the DMA channels then is non-LL mode.
> > > > - When a valid physical base address is configured but the client
> > > >   wants to use the non-LL mode for DMA transactions then also the
> > > >   flexibility is provided via the peripheral_config struct member o=
f
> > > >   dma_slave_config. In this case the channels can be individually
> > > >   configured in non-LL mode. This use case is desirable for single
> > > >   DMA transfer of a chunk, this saves the effort of preparing the
> > > >   Link List.
> > >
> > > > +static pci_bus_addr_t dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > > +                                         struct dw_edma_pcie_data =
*pdata,
> > > > +                                         enum pci_barno bar) {
> > > > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > > > +             return pdata->devmem_phys_off;
> > > > +     return pci_bus_address(pdev, bar);
> > >
> > > Does this imply that non-Xilinx devices don't have the iATU that
> > > translates a PCI bus address to an internal device address?
> >
> > Non-Xilinx devices can have iATU enabled or bypassed as well. In
> > bypass mode no translation is done and the TLPs are simply forwarded
> > untranslated.
>
> What happens on a non-Xilinx device with iATU enabled?  Does
> pci_bus_address() return the correct address in that case?
>
> I can't figure out what's different about Xilinx that requires this speci=
al handling.

I am not sure how non-Xilinx device operates, but as mentioned earlier, the=
re is an
option where translation may not be required.AMD (Xilinx) design enables th=
e iATU
that is the reason the device side DDR offset is retrieved and programmed.

