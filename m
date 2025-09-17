Return-Path: <dmaengine+bounces-6600-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6730EB7C6A2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2085D4642CC
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4432E7BA0;
	Wed, 17 Sep 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tYzZSWOe"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114F1B394F;
	Wed, 17 Sep 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110467; cv=fail; b=N8FiROs7B8Ew0ZnWGr/y3lKETTTm4QKjSTTgPyDtGMTcQACBYhBvNxGSWhL6vOUSYfxh2bIsba6aJGgNCM7lesyTu0YmlP7KwFYJOo3ZaXlhA8GJt1TenDZBpZlt7SvG3zHB/1Tai+tTh0i+vKl8Da71LXsLtZ4lrTcpcv44lws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110467; c=relaxed/simple;
	bh=6mShy36ppp/X9NUbdAjNhvS8FhAyfLyXLg8KNCQD8gE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arK3oxvNGUH5cZMuyODoWGNiI+Z58z4sKPNQPciMLLLrLU7V1Mr7reYPHTbl+hepJLgpVRI4d1T9CebmogipwnzKMGjNkr6A5uYIpN5EYARRqvNP6q1TD8FMDy4fNKuRMwzBtb0vTNYS8TzND181ohCC7KMfsHA9dk0xQ/3LPws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tYzZSWOe; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRnph0b1npazuKKNwpDPR5A/zl+6kTUnie7B5x0RAlspZWKijB4k3mRXH6MngnJk2ElnRWfPIlZxuO4Z13V+Vq/kfKpZpWmBpXpge97DDkMD5vd6BnyDtzAwmXbX5l6cKlaRVktliuTNIgMNFt/SIp/FQhWc3NTK9MgGnTX+XSiYaOJWpyICuM8Dwy8haso3Q826gPEEfdcoJh7bJl05Nx5KQ4RNohQ9Fm1aDxVSa2q4Hm2fhHmk9y5IWKgpse27nQQgXTn/T5wmFhmGHH8P3tRtaFnijPVsNfUM1mkQUsqa5/uoWJjlha9yNF74t77EsAiyUHuKxrTHZpVkyJnJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt+3U2m1rIzubRxypQN4dKczZGV3n45EzaVaWW6aUKU=;
 b=kFqZF0Wky9yP0JtQVgpi/vkhCd7eGB/MqN+zAFgRKBP+sk/0mySTOhWFTq9Yde1QhSFegGyWfwnrMr/bvR0bs+cepKfdDiVH+GqBE0wkIwieAPC/NaNdAC0f59DyeEoCwSAIS0Ll7hhuXwGRpN1iYh1CpqqinaHIIoyyr/2o3Rfbm6n9/r+viGx8WDZpztNJtqMu14TYzeu3rXswH0NozdxsP3lL28rd7kAJEwuYhGSlawGpfa2XsYCmX9mEzVh3BB9R3Oavpk7Nm8h3hSq5SME/ehrZnUjDN9JuNR0RFapU9YA9noiFh8j0D/scDivmBMwIKkQa1BLMsD8XDZIzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt+3U2m1rIzubRxypQN4dKczZGV3n45EzaVaWW6aUKU=;
 b=tYzZSWOeUBCmIDoZmHd8c4sz3gUm3ju7byKu4lvT8YdpAydMPDF1uXr7PC1NmN7sC4xxyxPzUR/+k0Y7F98Z/vG6OIF84RdOXGIwIW1VPQ5iD/jRgrCwqhCQnjzTTMwU91TgdTSwJJC9+JV4Oq0+0QmO8y8W8gMfIAjPEV56RdM=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 12:01:03 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 12:01:03 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [External] : [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB
 Endpoint Support
Thread-Topic: [External] : [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB
 Endpoint Support
Thread-Index: AQHcJviALuus3IFKp0WCOQ+SPn3pb7SV6MAAgAFeViA=
Date: Wed, 17 Sep 2025 12:01:03 +0000
Message-ID:
 <SA1PR12MB8120268B790E1FCF8CD185479517A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <17dbecb3-6261-4df4-a2ee-e55a398c732b@oracle.com>
 <20250916150532.GA1797586@bhelgaas>
In-Reply-To: <20250916150532.GA1797586@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-17T11:59:26.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|PH8PR12MB6985:EE_
x-ms-office365-filtering-correlation-id: a837981d-3f59-4c76-3390-08ddf5e1e00e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OD1W2/UHwAlMbyd8yCPwNY6XrNju6J3p9y8sBDrJDhgQ9gpOx7OV4ywXBNom?=
 =?us-ascii?Q?czPDbzGi1zZp6pX4veR4CIF0YdTzgQ+AWGEeMiuSr8A291zsPXhV2g7rTfv6?=
 =?us-ascii?Q?8LYt/bPBr5bVjp6U/Ok1udrGCFL4vxTAMIrHS0ST5aW4kOCG/kkQ5wj2usAi?=
 =?us-ascii?Q?iBLiXRYRtdOxtby2RRa3D2Z05xfr5hkmOPIdN3atT/dUnKgoykOVb+x+ABIT?=
 =?us-ascii?Q?p/JZcNSosSdWAixhR+k0x/Enc4pytFtHoqNKZGlVdE3rDPIwdmaTEM2NZjUW?=
 =?us-ascii?Q?UNcYiU3AemxlX+zuVoDtt7K6ArwdWcOnYQL76GVrONx5kdFjdBXBwbs88T+H?=
 =?us-ascii?Q?aC4GAVdeAmSHuxLBFPkF0dCzeBDyao1Jc10veSXVFc8uWgmBlMzchwRhS9EO?=
 =?us-ascii?Q?zjrmIAs+1wCWajCL3YiTm0mIeaeS+nwM2l7fjA+aTHdBaYlFTxUWnXP8M7OX?=
 =?us-ascii?Q?rdStFy+rgmLnO9aVBIxHoyyFWNoLaVMzcDUg9zo67EYMVoCAkGrMu90O90se?=
 =?us-ascii?Q?/HlJSnQa/gV8SbhVcaL6VA+qfdf46xbxx66EohRi0Rvqqag1Ac//KHZj2siF?=
 =?us-ascii?Q?st/bg/Z1ezExDfCoIwD260C19damFEVYSTLje8ebpluGBDAyM1yLu/O9n6YP?=
 =?us-ascii?Q?VJAKqqgQzeOfG33Xp+Vmt6UDfRxJu46SZYvtUkQu0ArwkecbyddhCkDkgRZh?=
 =?us-ascii?Q?Twa7Tu9pETFVLp7dbpxPkwo2AvtEmvVVS9niNcj7P4btNvZugjpr17r4aNwF?=
 =?us-ascii?Q?wkapawnqE68ctW9dsnmj3Z9bxwhti2rVVaqUVfqheyNhaqr/8dZZJCaIFJwT?=
 =?us-ascii?Q?hx4EIZas6uA64pmcvAdu0q1PyamngZN5V/yQfsNkl7mhPDVzWbdAsunN/Ylt?=
 =?us-ascii?Q?gVd5WGSR/7UnA8og/Tww3TwPkeqDJgJk72CMg5pt6OWBj5jxPAb8sew4DJjQ?=
 =?us-ascii?Q?HLAFSPnyu0KNihU/IVtWZlTL3LBFKI92haHV5c0Gl/v1cE+ppEu5+yg/6U1f?=
 =?us-ascii?Q?/yi3hD6nfub+VO3LNIZKvFZttzpnuRlBeKNcHoO9j/dWwlW0uFnI94T3NMWs?=
 =?us-ascii?Q?xkQuHnTZQ1WdnDdZVw2KWVJQmfuWircz6RLEhbQJ17UenBB5rD3UsSslacIn?=
 =?us-ascii?Q?VzoRs5oJ1PHiezLVy6sA9ixRdKIv0hQHv4aVFnom7gAMISqAznrygKN2CYCN?=
 =?us-ascii?Q?/GxcHDqSZ7STmHXaOJIANZfGfvFIhvPq56Tbsnk/m/R6nxkBBjF7jguLGz4y?=
 =?us-ascii?Q?q2AlpH55xypJYmHG/ZMKqt/0pxQIuA9egkNwKfxLJL53+jNgh1aco2cDw4R2?=
 =?us-ascii?Q?1A/qhq5eZ3kNrM+hd1BXPdEp9lhuXeq+sTNAUuR5aa0r+SZ2trDZZjDCp3JM?=
 =?us-ascii?Q?sVJeHEkUYNEV+CG76TMSP6GBFFym199RjF9lW9S+xkrRtRdIB8w85MM2A3LX?=
 =?us-ascii?Q?Tq73Kq8Szi+eyqjcnD2PcMcvWGwaBnvTCAGRUcdoEPpKMD/l0fqO+Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cT77n7NVF9FVB/LGSADDYoX+HYPr2pSkAO1Mo2iuQOniXBPnNklmrcmFtBQx?=
 =?us-ascii?Q?cjsTpd218nBAHuzXqTYbto+rhhv7TBIhwNbqzAzoUEuVhxxwWbJLG+BQqfET?=
 =?us-ascii?Q?BBCInFt6dq6E40hynd8Wg2i48PVfdd58fVESRQNMMp8gPb770eBgNoRiqVvY?=
 =?us-ascii?Q?mdYHuNr3pA3130pc20oV4nb5KYMcITYCsHlhQLCgXvbSMKxzSyiAWVxcD+sn?=
 =?us-ascii?Q?j1z+wyzEsemK4/QRD0oNKq4Kw5w1mhtH57itEqsj1KR86Lb6KHPJb7ENAvxN?=
 =?us-ascii?Q?GW8BIrIlw3xKMfOWTdMinbv8tGcsZx3aqY5oRjabCNzj3fGrIiYzHkXIKo9P?=
 =?us-ascii?Q?3eh+PenO4EQxOV5ZYQifFFJYkO50UGBoRudNAkls03vztnSElmO9SZiVSI/v?=
 =?us-ascii?Q?86DO4qVM/UCDTInOoY19Mu+ZtNIl4v0KkSOrY2FaKkLzoOZBSM3gzylW83OC?=
 =?us-ascii?Q?2Wogwj5PIIopAl5VosWor1wRgRindESrcHQs4z0kDQlaeiA9YyeHHlIlxCgp?=
 =?us-ascii?Q?KxORwiA7uxo3Qu8Z62zcoSDlAMk9g9plCG2GQCktznTZANYwd6zJcchomPoD?=
 =?us-ascii?Q?6GSt5tamt02SpXlbAmehItUs8sIfZkH/mUyPCBIiYy8N/rreb+zw5GniaYKA?=
 =?us-ascii?Q?tmh98kcUl2MKnTw/uDrEkvHLznTDKcr82soxtKucUwwkIjybWgY9jJcIEjAN?=
 =?us-ascii?Q?8/YD15+5+vd9M9OkcTaVvDBE830hHMr3v4pgeX6EKDmINrGEMEQ5mLP2fOwp?=
 =?us-ascii?Q?gzpqhiHaJXUBEjdfD1NkJ8E4RGftAI7uRAqsA/woKeLSBkvs2c1SbSVKRUD7?=
 =?us-ascii?Q?2WU3xp2OROG5ms2WheZggeYheLm7OT48b7ykhSUVN7KS6wSj4h6S2K8JWLc4?=
 =?us-ascii?Q?6+33/3QmGWm725Ct+73DVviv1Ed0Naaj8s9UdnkTzGV4JpY5uYhYPoY93vAs?=
 =?us-ascii?Q?ZNxFsgWgxjKU/bi2OVFq+lY5U3XDE1Jgetp7JUHSi53+bdnum+HH5FtXJfuE?=
 =?us-ascii?Q?ejyzdBNXQ73Sf9ismHhv9pe7Ge+afikaKMNFS+LIp6VjPbo6mDHp8DAg1/79?=
 =?us-ascii?Q?zQ8c1TfBKOUdHy637PD85J4FBK1yfDUGI5AyCQm0oLSK0Emi1Z7NWZn+uBmS?=
 =?us-ascii?Q?4fS4suStJ8yCOfFsRDYy0k630/iJ2w+ejNKnEHStPld+e+y10TUj23EKSi0c?=
 =?us-ascii?Q?1D5kpJkkXgOpwIU35ln8WLaICdG6Fa7rJwMdR7zLxhBN8VYVwqrubetzPcs0?=
 =?us-ascii?Q?GqVso5ZXU+L4zSfhbToVHxZFnknlyGbp3qZo3GirFhBk5cnHTTb/s8etoQjn?=
 =?us-ascii?Q?PJLVhv8i5kw3XyT4Ys7plsLn8I2x6wWSnRJU+T3xUHgbBKIa+nE1bNLZBU6W?=
 =?us-ascii?Q?3O5uOoQNO0RO69K/VXu5a3WG2a1moNcKqMot9NrOSVp2Z03akEU8SrDzPQlm?=
 =?us-ascii?Q?uslwipOlxDJLBklYoXJzUDrYCnZdlihmWFexO0nmx16wE3iLmL7pkOS4gchq?=
 =?us-ascii?Q?w23lkkfSryOBz/CRus6783TggXkFal1HNr7M0kCKCw4rwjc6A9CP9BVtJK5d?=
 =?us-ascii?Q?PI9PZBpSMENYdKrIbNA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a837981d-3f59-4c76-3390-08ddf5e1e00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 12:01:03.1448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RETasqEf28T/AJqZITn/7sK6qiutxtmj7SyKoAM5qaFa8yd+zvrXDKiHOJB2CA5+ebXH9l05dshrzaKeusbwbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, September 16, 2025 20:36
> To: ALOK TIWARI <alok.a.tiwari@oracle.com>
> Cc: Verma, Devendra <Devendra.Verma@amd.com>; bhelgaas@google.com;
> mani@kernel.org; vkoul@kernel.org; dmaengine@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>
> Subject: Re: [External] : [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB
> Endpoint Support
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Sep 16, 2025 at 04:25:49PM +0530, ALOK TIWARI wrote:
> >
> >
> > On 9/16/2025 4:13 PM, Devendra K Verma wrote:
> > > +   /*
> > > +    * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> > > +    * of map, channel counts, etc.
> > > +    */
> > > +   if (vendor !=3D PCI_VENDOR_ID_SYNOPSYS ||
> > > +       vendor !=3D PCI_VENDOR_ID_XILINX)
> > > +           return;
> >
> > if, vendor =3D=3D PCI_VENDOR_ID_XILINX condition will true
> >
> > should not be if (vendor !=3D PCI_VENDOR_ID_SYNOPSYS && vendor !=3D
> > PCI_VENDOR_ID_XILINX) ?
>
> Good catch, I mistakenly said this part was correct, but you're right; it=
's obviously
> broken.
>
> The alternate structure I suggested would avoid this problem.
>
> > > +
> > > +   cap =3D DW_PCIE_VSEC_DMA_ID;
> > > +   if (vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > > +           cap =3D DW_PCIE_XILINX_MDB_VSEC_ID;
> > > +
> > > +   vsec =3D pci_find_vsec_capability(pdev, vendor, cap);
> > >     if (!vsec)
> >
> >
> > Thanks,
> > Alok

Thanks for noticing it, this was quickly corrected and updated in v3 of the=
 same patch.

Regards,
Devendra

