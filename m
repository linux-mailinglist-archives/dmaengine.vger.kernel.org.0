Return-Path: <dmaengine+bounces-9480-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIk2N9NIuWmK+QEAu9opvQ
	(envelope-from <dmaengine+bounces-9480-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 13:28:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBBF2A9D91
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 13:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF893028ECD
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAB83BFE5A;
	Tue, 17 Mar 2026 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q325VesM"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE43BAD9D;
	Tue, 17 Mar 2026 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750261; cv=fail; b=CsNHkqqysOtPzcmnxb8bpZkLEYRzwX/hGdiwrkJpWlOOzK8r10L6jIR3zc18Id/m8p58Or7OkfxjNBrIzLTC2b+BDQpuYkpfCmq4QtITkFRQWzfz/6A4PPe6zvzv0tilqbzrrYy2Bnlj2AZcLL1TM2d0C95HtVouogrbz0liDaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750261; c=relaxed/simple;
	bh=QUjELgy6K0n0xaRYJR5iZs3C7Jf2pUuNA+WRvrzUN44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eK1xyCi8bcaSe5rHE84U8f1cAtHwbilfHtxrvqm2H63rVUA1CIPuh8B2/bQT26DToTPcdGlJpLIDc6XGij5uZc3CK7ZH5T0b4fMBlOgqqQnkAqsPBH7EJKiBEeik0I6BaG+SPJ+xa9n+6KSoM7KK6bIHyqVXCRljpQiGA6ueScg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q325VesM; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQVpE1T20wnpZBXVXmDN7UA1FLjvtjdczMPN31Jtx7n3FHrM1kPr2jiuAGX5SZaefFoW1NYUvKoR8ah68zNa19PyOtstqA0qvUcOOYhB4dGZnLjJWJlMa54N3xNMaiyBcFjO5bABv5H23k3+TOiitAPHzn8RsAfrEGyJ90r93z31Pl7mtE54nEjq3YDj2IZ2ZLXneVjADAOHBHa6ZLg+rzEjGQu/37EiqA3O2iZ4UhuedkyRetdaPYK4LwkNfu7ScXXJDqlb+YXFJIf74LGXMhFJ5Iw8sAt5Ip8O9t2qIGq4F2LjnIOn1RZsvGni4QZl/5bWNbQJBaVqHD6ARyVm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsPL8Jt8R3lpGEKh0g3+vGabPUQripbFnvgmsfJ17Fc=;
 b=KMkiWBKlTNGEC6ZZN2Tv8A549jjqQcYXlUbWljwtCig6gUNwwJi3JzWCIWp1+otcJjJYnWPJg7+pmx07FGv/aQ1BozxLPAr7+1WKqt05g+QPtu5gKt4rYTf1AQ/+v4+2cub3uf7coYrajsSDb4VQN7PSQwOwjN7Mzo107ynvs7ZwNNFqBKgMOozVjsVGcGUu1/XjXNOl8oWJTwtDdZoxm+HUEt+u5olvBYKao/ADVN4E8NoRgX8KzOMHYlzBtl4JWoRK0yXduWKesLUtYCuzff3MqEkkKbiDZ/9Qav8SratvPDLZyYLYVI0zfQhi5NqteTN+epO1vkZ6xeiGwXvIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsPL8Jt8R3lpGEKh0g3+vGabPUQripbFnvgmsfJ17Fc=;
 b=Q325VesMD5u9TkcY8azZxgroNzSop2oQMzMh2twTgHsPTW4oZweLcIBzgXFby/EReAykRsUvTwicn4z9s/WLl+1QB+EbvlRyL5ktuiD/dHsx7W+LbjvqVDD18Y3Bysy8uyeHh94PnMtCP8LDLmHJMKrs2iK0rVUEGJIOOIPeKQY=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:24:17 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 12:24:17 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode Support
Thread-Topic: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode Support
Thread-Index: AQHcsUjRM/Dpzwvbc0it/CXmLkvpbbWymKgAgAAWBZA=
Date: Tue, 17 Mar 2026 12:24:16 +0000
Message-ID:
 <SA1PR12MB8120B73E1F0B6BB8035AA7219541A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260311111834.3750297-1-devendra.verma@amd.com>
 <abk04pkF4mOR0rKP@vaman>
In-Reply-To: <abk04pkF4mOR0rKP@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-17T12:23:20.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|DM6PR12MB4434:EE_
x-ms-office365-filtering-correlation-id: 44592358-c74f-4337-cf8e-08de84201ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 SLwtzQxVLpq0gNPtoP8fXYjkMefjDdtXXiB+0XKidwmLDWAN3H1tku8llVLbZoTUPyUCGn55ud3NR+446DC8Kb5qzR3hEWtQDFFRJJNXXY7jSN2V3pF5yVVGd+HANbyZ2z7bA+JRSEygiITK5Pslm5U+lEWiKfRlHmGnFpCJFkJRjrFzPl+Y4HqlCke1cSqL05TanFydHfqZXvYFby1uEDywLg/14vWrZ/Ml2WNd39hkosFoa8nzA1G8oN80U1cv9oF2CmZZYoAIBMW3sKGErMuR7E3UwODWRdDVGmo3xvxscNyMB9X4Wfpu8qx8/I5JHFvQQkVlZ5J75g1KxMmybraNGmA3EIXRrbNZso+k4YVCdwm1DmKGGmO1+I22in6DrxaL7XUb0dSLKZvjKuLVQ33dBSYj96VuGpQsiX2L7GWovXz9TJQ8SFkxMEv7SFpczek6Ofz2TEr04WQr7bgUFtiVSPsNM55OaiAYdMw9MD6Fbsh/YJ1qV+UYV0xIgmP5oT8+MDmxEhZ3r22B0lZNpcbV+BTij+NKxhQ5QvflfGkZmKuOdb6SVqMAT76ewy8JawhY+zSG78XpYlLSa215jh+LNjwTVgaKaLdl0nkqHIKxlYDY6chH2+gGI1nsxlPKRyCpqlCTcslYDAo3ldN+KeIvXyHMBK+upwHl8o2d4JX+zuvSrAO5DhmYT4/RR8bla8YYspGOwgd/EPbGZPIyxVBCxwImZznsXfEymSM2DeUz+oddxkRuNC4SshATBvPA3D7dDVBCKYy01BW3gR+OfiaFQzXQ+//5wqVol4DkHBo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?whG7QFu7oDICjxZvlNtxkY5hMzzDI8GJYRZT/r8gfBaGVxgI1Jp6+/7Sal8M?=
 =?us-ascii?Q?gFVqlm5ySeTY3R3HHokR1beMzg0YSHeGFIA0FC0vhGh+309oyhd3nBoVab5Y?=
 =?us-ascii?Q?agGaADkovG47+dNkx0xJjTSxzxNfWodnLsWd02mTrFpYoSQb2XgyEpqV0k//?=
 =?us-ascii?Q?ICc4K+A+6T577agVTF+WENL6YUeV/wHy6AQxVpPQ7Tj6ESyPbHjzG/S3WDxF?=
 =?us-ascii?Q?5OWDQnf4Ca9QObGzXWfwn4Z4vKKBfs2AGSrWV4QUssJGL72lqMeCF/vZul5P?=
 =?us-ascii?Q?vtz3Bz9PPp9akhf+qahiOKpLuuvuzDJAK7ao76O+PtrBodr4aYEvWvZ9jlUj?=
 =?us-ascii?Q?ya1fhmTiVGQukzv6i0x6JxmJVHLBFB4+IJNiNH7O9MUDNwRfgM8HKPkE8hE3?=
 =?us-ascii?Q?1mnfeMVAsYiUVPhfYW20n/5qnOpl2n7x9OI1geQGjh5rnNNiTL6OdoLBol/e?=
 =?us-ascii?Q?eDFs/SEuVGhDS+5/c0x6cfO19dGs614ZjGSe8U2rTicbJSAuKb7JPu4zv6Ok?=
 =?us-ascii?Q?xEWl9q+HFkaA2wWnxq12CzG5uTQ2lu2aMlwglOTaQGWJmysR7tsltotK0aUM?=
 =?us-ascii?Q?kealDPRpbOfAz63J+kcc6VE8pwaHDKShJ1V09ElnxB2ZOXBkS2kgZmvae7NL?=
 =?us-ascii?Q?kllFjEiUyAkwySukOKzueTKPYgujkxVbN+dTHTKiwbj2EvOfMTE+8eU0huKF?=
 =?us-ascii?Q?6KJ+2IMfWFZgm+UXqs+6KhNjABezv/cmooZXKvrmIkjLMLAAdMZVFqeKpKv8?=
 =?us-ascii?Q?fP6boTOuIJ/EBqm/BjMm+rZTMqRJwG5G6/WFp+h/gm5ILsfg5x76HfCb3A4o?=
 =?us-ascii?Q?IBMC7AOIh3o8tWk9uAmatQhyAn9UkqAWY6d43uDmSaihq7RpaWHhkEFx+7x9?=
 =?us-ascii?Q?j2DzhQFUR7lnpfPM1jZtr4OpDsNYPNSq0lOY25WWoKUC1MHTXu0BCjnOF0XO?=
 =?us-ascii?Q?RsKJDXwes1k46ls8jsuLPKcmdO+UN9plq0s08wngqJloWCTyAjZTZ69j6r/n?=
 =?us-ascii?Q?clTIvR6wVVKjCgXm5uXOlVD50+Eqw9JOkRq+GDI2yozyBNudUW1s/MeKxrlZ?=
 =?us-ascii?Q?RTUgJs/5xTPboUdVW+seJPTh18IaZ5QdOy2ph4feLj/oS/9OnwXOXA1xxT75?=
 =?us-ascii?Q?7mRmByTUtOgg6xvhv3xWfE3JNdJgulyfFkpzMxriF/o+nqFzZ2fiLodZ/hLQ?=
 =?us-ascii?Q?Daryva1vZf98+dm4ueGcJWQODUWcFyEXlj0/NC82HQcHCH2wX4R4mD5+u4pO?=
 =?us-ascii?Q?ILSYgVqjp5tuswXvfFSJJKR12nHaNLtgGO7uCWlMBNYN2mnuFxnZt/GoJ1r5?=
 =?us-ascii?Q?83ncNG20gDZmP4fU9QTztqVbHQIeyYVZ6RMVgdf1BeRqbh8rlYB3UroJRlyy?=
 =?us-ascii?Q?KY2juTZylgv20NUplZ8A+0KxGkJPwemTO/EGF71bTNhZQfunBFyb1nSQuuUT?=
 =?us-ascii?Q?/cIvLZ1NwIn+9N9wszoKOwBKHWNliwNv/Bwd++CWbQwNN9HG1FxPcQ9GkZpm?=
 =?us-ascii?Q?xpCjV4jJP2LGQ1Ji5iq2lrpIQ0QjO1bUrk7tP2SnwiX7o4VRv1VEJtUUj5zC?=
 =?us-ascii?Q?Tl8hpCRN6X/qFIfS5zc1ch6yGU2+DlTzUfLHWVY+NPSDvBB6JHmfpKV9Ppyu?=
 =?us-ascii?Q?osbEeF53v3qcDcxsTKIeWx60hi4bkUkLBsc0imcdyHwDBGE7spQFjB3+OFu6?=
 =?us-ascii?Q?sZadsS3RLAP8CwD7DhW9icFpeRoHvwzJrlKcMptntpr3Iyqo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44592358-c74f-4337-cf8e-08de84201ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 12:24:17.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDUSL2GAH48ze3/1b/ze3tQxcsu4sJlRUZjD029H4AH2uaQWUmcXsB3ORSa2i41hFKPXvZvOnp107HZawQiSmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9480-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 8DBBF2A9D91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[Public]

Hi Vinod

Thank for reporting the error. I have submitted a new (v14) of this patch s=
eries, please check that series.

Regards,
Devendra

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, March 17, 2026 16:33
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; dmaengine@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>
> Subject: Re: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode
> Support
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On 11-03-26, 16:48, Devendra K Verma wrote:
> > This series of patch support the following:
> >
> >  - AMD MDB Endpoint Support, as part of this patch following are
> >    added:
> >    o AMD supported device ID and vendor ID (Xilinx)
> >    o AMD MDB specific driver data
> >    o AMD specific VSEC capabilities to retrieve the base of
> >      phys address of MDB side DDR
> >    o Logic to assign the offsets to LL and data blocks if
> >      more number of channels are enabled than configured
> >      in the given pci_data struct.
> >
> >  - Addition of non-LL mode
> >    o The IP supported non-LL mode functions
> >    o Flexibility to choose non-LL mode via dma_slave_config
> >      param peripheral_config, by the client for all the vendors
> >      using HDMA IP.
> >    o Allow IP utilization if LL mode is not available
>
> There is trailing whitespace in patch2 and even then it fails for me on
> dmaengine/next. Please rebase and resend
>

Corrected and sent an updated series of the same patches.

> --
> ~Vinod

