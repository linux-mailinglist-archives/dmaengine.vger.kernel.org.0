Return-Path: <dmaengine+bounces-11184-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JpAsDj+zImpmcQEAu9opvQ
	(envelope-from <dmaengine+bounces-11184-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 13:30:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A2647BAF
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 13:30:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=xFM5lQjb;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11184-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11184-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98DC7301BEEE
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B04D8D88;
	Fri,  5 Jun 2026 11:28:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46874C901C;
	Fri,  5 Jun 2026 11:28:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658911; cv=fail; b=s04hOw9Xj6PCCxBk3oVZrMotwE3KDsVyrs9ED+/Wbvc1GCgf+HmQMjrSSLIic3prws6T2ES+OmOKnW7HelsrK2vjiFt90/38efLHv6uUYJxnbE18dMFD6nGskjL77j6cPRw3Q8l6DN8QubyzbqmaGRS77GlJnIJA9I7wqPNkaaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658911; c=relaxed/simple;
	bh=CBimzqcFtmI8AzRfYDjQclvLHMp2B1BcBDBgqSNrHbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DjpJ82+twPpFOCvXrGPjvzJOBOz25AjuFHvVMgklhoJdU8f+15EwSqMFK0lDtMbyHhr7aRP958chnPvzYCLjz+zdfYvvU8p6qUeSD5ryJoebeDTWVkOUSTf8uHuX8Qwf+vIItr3cJdPLM1bDU/0fnBgXXKbBqHE8xJrCs6NslRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xFM5lQjb; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPvDUH6UziFp60z2oYde7Y6aQGDQIZrpupxMbIjkmhuD4938B1r2m8/4Qv1i2gSOH1J8Xu6ESUJ5VwoqxjDG0jmKUbSzD1Tg+n30TfO5yaA6/5LNqapZTlO3GD4DvnezbKqIVUE4XyIy8KkdOQTIzVMzswNJ+8JT7qDB7vxzOV1K6Xr6PSeO0PtHtORaSIzdOV67jxf2/xm1RY0w9TdJqhap34xKBY1ETEeYVP5T3ueMYIJ5uRw7eCkezpa5eCsk3K6wbwOhSuriEcAlGCjelfO5zU9cctkR/RbaK8hOoP+UDo47Xqt+6bGp6bZl3280RAslEfJxUtU9FYF0CKQQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+aoyNEmJCZsY43InSVYgaNLiYSb0txmLTZiJWjzJkY=;
 b=tCphgB2jmU82gQhSJQ4Xowt+vvzfUlMZbFrjfoQ1mSR+KBKwoYth/jE9rUAvAGNtfCx+sIVeC7A15pECh7Ji9ji5eGZKMyBxZp+UmXj54+tVBnSsywTKqlv+JpGp0LuEJCS7oEUq4KzvrGQ1RKaPJeyPRJnYv+WplJuJd0KIjYzK6ywOu0h4cAP4vMyyAxZooOdVH9S1Un2zPFyODndhenGtrSL8ZyzXC56okFWiMtvZ7Jw0ryoi0HJZe2yibyyQCOCaiPNojFdgCvClykffDEaL7wOI1Zu9GGlSa49Yn+PVUuKtb97jIBALgA94xCZV01s3BR11qU+35XUbFZhnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+aoyNEmJCZsY43InSVYgaNLiYSb0txmLTZiJWjzJkY=;
 b=xFM5lQjbxRNedXbQPp5Ztl7tzR1Y+AFsQwnw1U8YRD8i7b6v0yf+kX3V35ADwn46kFVUPUyUowRBOpTFg/7EIxT2UvEGBp6hLRh8fpeUwJZGFCzeGuBOaRxedJ6Jy5T2ng3btkkonrXvZK/UZfrLOZCVzx3vNpPnJ9BJPdzjLI0=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 11:28:27 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 11:28:27 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Thread-Topic: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Thread-Index: AQHc82X6OzOMXJ0Kz0iYp8qveJQ9C7Yuz02AgAEGaPA=
Date: Fri, 5 Jun 2026 11:28:26 +0000
Message-ID:
 <BL4PR12MB9482239D14423E6EEED2E84695112@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260603143158.3243500-1-devendra.verma@amd.com>
 <aiHWcdGfP-rdRn0o@lizhi-Precision-Tower-5810>
In-Reply-To: <aiHWcdGfP-rdRn0o@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T11:27:12.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|LV3PR12MB9411:EE_
x-ms-office365-filtering-correlation-id: f75ffa01-ff62-4ff6-5cf5-08dec2f58fe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 7F1u39YwXbkJpWQluepDfd5YSMj+nw6c2tr8GWPidLY2Trxw7JBh2nbXnx/roQ0ECNDZq2VvzUCkp6m/OHz5ey4Sr7xg9WG6KZxpw2MhWNj5xs3yq+2Z77ffwAYkfnOjptdd8ORcRC+FJJz3DQVtZeUSm5qysrB68Y6LZBYiPC9jirVGg7ftAG6rH64aKxJuJaiT/f1G8r/WS1Q4EqRawGC5ni/BMcHTAid8g2qqxzkhWYLWT4inq7ZQT9o1lzISh8R4+XEsujtY4SSZXKbG0BjxKc4IRzxEDhJZSGHcaFqfBjDVc9U5eNVVkJYgRuvIxHdYXBKtYBVtuVKD7Rq542UVzzsHdQjq+VTLZZlrefWRZhyHf7f4GSvf6pLgVDjCF/MsA6JrppVuU7kcmhSQFax3qRocV8UaKW3kqQw/8UT3w8AMlM02YMoamLil+y6zTBOU45Vg3EhmzxxWHJW9q2VSbEokQ6ANysjHZ17Vf/uUA8qLPWc9CgRsw5qeXgDLq9T0TB5vb6G56knd/jaDhnnQ8VkCxCE18M3zmMSLBhAFOq2clPOoklh1YNSE6QCvx9eKmYt7tXEJTmM5nsO6vvcSbB0Pg4pCwoCWR+7QLhnNhOCx9pV8C/egzE0YLH81xSEY23EdEWcwSAQhTUNQdyLWyvl5+sUZbmI19FerRIzwJKPUT2leIxyu5YZDd2B/Dd0pULd+NczE95Y5LxrStUJ9z+zEQskJumKgvJbE+TNI4amSVfa7ZJ4SfUnTU3Bp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?t/Oz6lSIzKg9CL8QEZl+YCLoCXZaEznykA5zZx0ilLxdGxxxWNZrU8EXXZ?=
 =?iso-8859-1?Q?9A1fyF4RGgYS+j0tVACN9nMjcnqGUj+Bj3xIy+1yp9k0RzegXwiA2feY07?=
 =?iso-8859-1?Q?RhnHLj22XXchij4YgA5diP1d5W60QTgPHgpNGH4hxWIjb+s3WKMxzWIuKX?=
 =?iso-8859-1?Q?cy/7FJvwilsbrFV2CGUausFRDVWjm8i8qJbCZupW++oOfyM6TpqBkg+CZF?=
 =?iso-8859-1?Q?5vp3UPq+GAbXx4jrYNRy2/018OBBEtBpPbSUEyx/bptzIMgLHxYh6WUm/6?=
 =?iso-8859-1?Q?rLKs2IRnKGiZ9ebdlRjqk0ykr7uJO85BRIYuGv1UsSvi/+Yx+G7/c8f2hV?=
 =?iso-8859-1?Q?iRrZ4EwVbwCzG3LvSxVi7HCplm9Yc2rYxoJP2RuOGDsOMe8r+88KrXkNge?=
 =?iso-8859-1?Q?eOSR3ec1tmA+hExMnRXf29XMhTOv0IHgkSNdaJ+OHA2y75sGlJWDpRNAzU?=
 =?iso-8859-1?Q?fTBjahD6614Mce3fGFfBkEPwpBI7tY8Q67ClMaVU0a1B+RxlyZodB8KvnQ?=
 =?iso-8859-1?Q?A0MCU+4v0Ijz6Y6UwHABTuIp6qmWkdBAevyd1kirzErBiMvphQcZWU1rii?=
 =?iso-8859-1?Q?/TRIzWxvHRiGkb1Vx/EQsKDOMqKssHXV1ppAE3ipPqz3m/wUqVSVTpBlZp?=
 =?iso-8859-1?Q?5tDKdGsrMYBq7b0enVhVQ8fZOJz059gXYv0v7X7OKtJK0PufsqHxBkqxbU?=
 =?iso-8859-1?Q?BmE9Igl4YBXEAiFRiDsXeolhRdw26CJUW0xHI8W86Xgp7p0RcrrlRkGa75?=
 =?iso-8859-1?Q?1Wsb9ILzXhbR/LgTIiYHrJ/quvXAIL3mfyPk5OJb6qGCDPTIXNI1EZJsiG?=
 =?iso-8859-1?Q?qC5wK9/XVw2zhG1Fs+NakRya/g+AdOO5BOq4xG5dtVlbCJwSqS2Zz1qK/H?=
 =?iso-8859-1?Q?rv5d0ZvdWX7x+ea6qKRIAfkmGoT+PsfwP6NyE6Jh3kK1Gr/X8ZqWVa/g7D?=
 =?iso-8859-1?Q?QX/iDBXyHJ+ZgT26zhp+R1ceD0KjpcF6BhY5DpOdzXEebZo2NOGrbI0PtP?=
 =?iso-8859-1?Q?hC/jdwjLPQFCzDFCxJNNf9e2WjyGQ+ZXeXIDmZ+sRyy0D/jVqHWEMf2nGI?=
 =?iso-8859-1?Q?lG2Yu25f1PvtQwO0SOcRdYwXI3jT5uBpxc9RZusJgteETuJ0KvvU8Rw36f?=
 =?iso-8859-1?Q?NfRfgNbEty2OSUv/ZBugZ+l6MuvBrESw+DrSkg0qnqUWaJMuXgrEtRUIhG?=
 =?iso-8859-1?Q?kWWospLEOQgc8XNuqemjhGVQMtMc+oJjHd9Mfbu6r+8hxPrtrJk5Xw2Tfj?=
 =?iso-8859-1?Q?5GMlPcCx+h3Dxj1FtSXu4LvWNoAzmA70wBfeNWIm+krHdJgLNjxOxr0alG?=
 =?iso-8859-1?Q?ZKV+iIB9ryc/DcI9A+nkLEnzPIA+BS+wD28bIPw6yz0EDLWKOsAB7NT5Vy?=
 =?iso-8859-1?Q?DZ+BgIOvQ8M4Qou/77oAMGtEtUPxt0YXMtK54RTh9gSWi/mjTKVOhGXGdr?=
 =?iso-8859-1?Q?6/NZNGW0sL1Aq3OeSMckwtKTXjO2lHP6ZSG+zqNxa2uuw2AFMZOkSDZQNZ?=
 =?iso-8859-1?Q?OwW/F5zxAULJkZiOhJBJl7wccr4ZdCKnjxcijyHbIz8lbSzFLRpNG0pMb+?=
 =?iso-8859-1?Q?h4HQbyaBC/WkMYOaZz4/tpo3I47M/nZtZUU6dtNjGsVWOU+z+5b2oiRP/N?=
 =?iso-8859-1?Q?Vcbu1E1d+Dmislh5auYmsflrzZCghqD3kasvUn6ybQ3YzfCX7Pybo/0qX1?=
 =?iso-8859-1?Q?S83D/1rPDLUFHBBcEUInKB0PXea1vbGsh6d+6m/oika9ieOFfYZXTaorpd?=
 =?iso-8859-1?Q?pr3u8h9FE9PC8Re0jlQHRYYc5Iy5UTxlNqcMoOhn6tVAYq?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75ffa01-ff62-4ff6-5cf5-08dec2f58fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 11:28:26.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfAPdNgs8YmGW0nfBZzPmJFs04Vu/nuPIxXprzboD43HeeiwZeuW9FF06Ww1FPZ1BS0PTm2FXjXijMqlUeuCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11184-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BL4PR12MB9482.namprd12.prod.outlook.com:mid,nxp.com:email,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:from_mime,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C76A2647BAF

AMD General

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Friday, June 5, 2026 01:18
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA
> DeviceID
>
> On Wed, Jun 03, 2026 at 08:01:58PM +0530, Devendra K Verma wrote:
> > From: Devendra K Verma <devverma@amd.com>
> >
> > Add Device ID for AMD (Xilinx) CPM6 DMA IP.
> > This IP enables 64 Read and 64 Write Channels.
> >
> > Adding the relevant dw_edma_pcie_data to use
> > 8 Read and 8 Write Channels for initial commit.
>
> Nit: wrap at 75 char

Will be taken care in v2.

>
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 0b30ce138503..4ba368d18cb1 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -27,6 +27,7 @@
> >
> >  /* AMD MDB (Xilinx) specific defines */
> >  #define PCI_DEVICE_ID_XILINX_B054          0xb054
> > +#define PCI_DEVICE_ID_XILINX_B00F          0xb00f
> >
> >  #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID             0x6
> >  #define DW_PCIE_XILINX_MDB_VSEC_ID         0x20
> > @@ -125,6 +126,19 @@ static const struct dw_edma_pcie_data
> xilinx_mdb_data =3D {
> >     .rd_ch_cnt                      =3D 8,
> >  };
> >
> > +static const struct dw_edma_pcie_data xilinx_cpm6_dma_data =3D {
> > +   /* MDB registers location */
> > +   .rg.bar                         =3D BAR_0,
> > +   .rg.off                         =3D SZ_4K,        /*  4 Kbytes */
> > +   .rg.sz                          =3D SZ_8K,        /*  8 Kbytes */
> > +
> > +   /* Other */
> > +   .mf                             =3D EDMA_MF_HDMA_NATIVE,
> > +   .irqs                           =3D 1,
> > +   .wr_ch_cnt                      =3D 8,
> > +   .rd_ch_cnt                      =3D 8,
> > +};
> > +
> >  static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data
> *pdata,
> >                                        enum pci_barno bar, off_t start_=
off,
> >                                        off_t ll_off_gap, size_t ll_size=
, @@ -
> 547,6 +561,8 @@ static
> > const struct pci_device_id dw_edma_pcie_id_table[] =3D {
> >     { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> >     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> >       (kernel_ulong_t)&xilinx_mdb_data },
> > +   { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
> > +     (kernel_ulong_t)&xilinx_cpm6_dma_data },
>
> Please .driver_data =3D (kernel_ulong_t)&xilinx_cpm6_dma_data
>
> Now Uwe Kleine-K=F6nig is cleanup this.
>
> See similar thread
> https://lore.kernel.org/linux-i3c/20260504143324.2122737-2-u.kleine-
> koenig@baylibre.com/
>
> Frank
>

Thanks for the suggestion. Will push the v2 with recommended changes.

> >     { }
> >  };
> >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > --
> > 2.43.0
> >

