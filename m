Return-Path: <dmaengine+bounces-11183-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CGWCJI2yImoxcQEAu9opvQ
	(envelope-from <dmaengine+bounces-11183-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 13:27:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8BD647B42
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 13:27:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=kBm+GVaA;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11183-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11183-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BF5E300915B
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D8E4C954D;
	Fri,  5 Jun 2026 11:27:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FA3BBFAF;
	Fri,  5 Jun 2026 11:27:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658827; cv=fail; b=TKc49sUCPc/RWOG6wD5foSFzaswVfdoAZipHMnToXtOt7F6i2C7+M2F9NtWSfO3vu7MadW30j0DytdyV/V4AQoJozSBVSD1qKK+v5fuYqp+OMpjX/f3hPCi4eGs0EQTmRubCDjpkHZQtnFwXDx2efaIjBQgbygejETlcO76JFoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658827; c=relaxed/simple;
	bh=EiTMe4jeAx69eOVmvnkSJCVNbN58KF6zJ0SEPShUSgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuHw/WXM3UrId01PU8nRoVP+Fmyn9lXPu/Yi60hHlD9AlCMNzvSY6S4khw4wRFDRu/3DOn1lJSZVXR+BHFAn1bI42plN8AiKNzbqlzQkfJjORi6jSj6dCyYQxrJoAJbDzj2b+1WJb0besQ4e/4jVcEUTPfq6jjDMT3CbNdq9pf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kBm+GVaA; arc=fail smtp.client-ip=52.101.61.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxydUxxZWKtoIExlD/2ZAyfjqKVQU6MDF1GtcSih4s5BBS2qffDye9UppJ6QU5Z3lTpXgCVWTYiyKAyGs43wtEl6Oj4Zhbz60f2tiluw8K/WIzLVTxIAxAQFZoy2vmMSXM+XodPXFb5oDT6ILBAdJpcSSZHOdkae+xaIDM25O8XUiirC24ASiXRffbDXtZi+CM0+9k0pFOScQ5razFDlPzzV9yHgG4JQcTuxyj3GtzO6OSwd7XsUVHIsXYujVavMWs9xU4TewqjJ9bsMISaNDrOeOHcpkSjCbl0x2++b6K1WwNuZC9N8BEJdBxxTPO0OoHutspTFJnJpEQ1nlarBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuEPGOEzt1POEjj8Fp57E+1MwSqXGmp3JtH5gy+f0Cc=;
 b=eCj3DuV68MH2InXnHeksnU9BwrKm4WTCspMntiPam5D9cI9owUCOk/1fJxWuH3KbTsmyLZIM03uO7glKswRJFIp8Q1IUOjP2AihVXcizA9WikMeoRh8OYZq/DGHp8X8IYxnFjzUTeAagk+SKvA0UaqkdgRVj39Ox1MS3AFnQ0wUBRei1yQzP7t2yBGxBJ88IyVknmkULfd8eTm6gakrgRqPHj+sbek8Sxxv9uM45yLNAvBxlouk+7xk49upObgsYboSQObeDFocNqgg8znycw1ztI30MXFeyUxNXmmicHFKKJG7HJq6pqhZfN1kPA5MQG4R+vX0ZENVzkFAktEkZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuEPGOEzt1POEjj8Fp57E+1MwSqXGmp3JtH5gy+f0Cc=;
 b=kBm+GVaABDaMUSDaW9cmITj1rPRw7zoWVx8Qca58RPbb5GTT5X/LxoDk1OnNhIXwiSmYYjRlaoXuPbgfetq2TaCz0bO8z28N+xqBuzjCHtTl9kLYFHIedWAdKvAcZJxRzOTNxuXzj3htoWteVi3E8mqA8003z9oC+xkma3AKVVM=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 11:27:01 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 11:27:01 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Thread-Topic: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Thread-Index: AQHc82X6OzOMXJ0Kz0iYp8qveJQ9C7Ys6DwAgAFnk+CAADj6AIABSukg
Date: Fri, 5 Jun 2026 11:27:01 +0000
Message-ID:
 <BL4PR12MB9482B102C4B19C57F110CC2995112@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260603143158.3243500-1-devendra.verma@amd.com>
 <20260603144445.562521F00893@smtp.kernel.org>
 <BL4PR12MB948277305F69CC4A87F0D1F695102@BL4PR12MB9482.namprd12.prod.outlook.com>
 <aiGbShotOS4usSdm@vaman>
In-Reply-To: <aiGbShotOS4usSdm@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-05T11:26:27.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|LV3PR12MB9411:EE_
x-ms-office365-filtering-correlation-id: a574c041-8a25-4e5e-d4a3-08dec2f55d18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 8ZgZxpjlraqsUbfo2Xsnn+ZR+jQimTnQXRtWNYQ7IVe4UKdBjluMnPdrsFrZjW5xqfA0BY8b4eiUVKPjGxXEuehKHpz3MTgqEWzapnBzUhkOkpjYLQvrTmtdjZGePzGPmvdzLwxsi1PB7OlL4RfTmU9p9yxNSc78MfA6lp2AbYNYS1qGEXhxTHN518mkjHWSII51D/43SzhoGNMeizRRs36xizuFC2hkxTF7eIOZaz/nXn3Yl2a+ZKLcj7tgm00yfFoL9IT0wwB3ItgQthst2+GZW30G7Aqfnb9c2hMKLOWb/xNxC1CPbzSpRMFhyeNgdIrjFlyQDg67P0ItHV0USZd62tZL/K+SLJQSbFr5IGkSSxh0YrpTUOsikyz91KWXIs8u1f9cKcycCC0lC5nCITbhCiiWXMAkS69lO8w/TGGy0LMdNiOSF7aVXImgAOtsYGKwN63R4ZI0qgZZalmHDAJ8NG13QTaD+Pj9G0PLPWmSUm4sTOecMwO5W1h7NKve0GMGmpk8g9q7mjwKGJMtzOOgEJZciDWnyTAXPHzODgm8dG52+gDqg11oSIaJ49apj4slQ6r39TOQQGW1pmwLTToxQVPe50rTcvTSdQ+yexUyI/ZWWRKewoAQyHopDDBj3eHpt8OolmErUc3mA5ZC+efHf3SwaEKEiXj4DOf27G2Z8t6ABtUIwOJdHgT/qWrt3CEFAEcdGBQhoVMZa0ZPyQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eALSpNq++gbDgivicSbUEN0PJETNM2QEVIeCabIid5YJp29gkiM/I2ADpmeS?=
 =?us-ascii?Q?0H1wJffEqGjzq6gjhfssS0CJrrYOSZBGYeVhRCNrVfRdMe9RlqPNQ2CCA46u?=
 =?us-ascii?Q?i35vWo4GanUm4IlBUv5ZEaQnLHIAngDZdq/3bJfgY+8YcPM4H9hh953df/5V?=
 =?us-ascii?Q?Rk6+K3G6M0Qqxh6RV2jcjSh0iY/5ZzhSiTLSvdUsPoGs7LZJqgKE28bSroIk?=
 =?us-ascii?Q?XLdsG6AGGUbHFkzvqU22huxWNTjCBBtKWiUJlvg2v6fnKjbKwJgKKZVAxn7b?=
 =?us-ascii?Q?KIn9aemNWfvqK4HB02nWOdrR0/NF84aZNAo6lNUf8A6WVltWLe6bV08Sumzn?=
 =?us-ascii?Q?Axuveervd4gkKY1KWhsDIlKTlBSrkJZ5vbMMpAU4Dyky99WkbrUtFPRRhpWU?=
 =?us-ascii?Q?/KpFUdV7Jk28dzkXqZmuws3gB5zlSvmoZjy5JuMiiDDFW3jVM24bJjNsLGTX?=
 =?us-ascii?Q?CM226k86yg/hKF33CpOJlnwlpIPG8IRvhgxK/8Vj4j0AgmSlSwRcT5CvZz/v?=
 =?us-ascii?Q?fhIKdyxkKplYu69HqKRxC+CB4E3o0DaHtwBYsBQjtmzBkua5gi7kKiIJ3X8t?=
 =?us-ascii?Q?2WB/HrYADqYyIeTzWU1GKZ6j6ANO5sLhfl0ssWapJZdmEGJbU0W6231/WlUn?=
 =?us-ascii?Q?HBfwat4GF6KBecEmgFK45PmkfXtf7JQpHeac4SZiGkRGqkSrq3Vtbw3cbO29?=
 =?us-ascii?Q?3jv/VGR/qhykp0kf65K6toq6ay7eWrPrsOU/ttI3BwPR8q+7dlt1jzCkQevE?=
 =?us-ascii?Q?bfyuRrF1/82i94F2M7mQLIhCxBtbKts69k3VZj3uzS//ZDXXT5va0p+ixyP6?=
 =?us-ascii?Q?lHqt0MsGGjKVMLFtXzbtJURzjqlr1gLRQX7n+JQM9vpiKgf8UYy0fcPQrjyr?=
 =?us-ascii?Q?vU20AQ05I9Q9d4g1EUuP2PD8ymX52gI0qh6XsbVDC8mtoosMgsq6Ll5nS3Zm?=
 =?us-ascii?Q?EYp4kcdvyMJpkJyB33GimFfWcPOnP7XW1Hn5zv0IMtU/JnwP5BKBaXLBQ6LG?=
 =?us-ascii?Q?RhQROFtTH+M7DnuhpbktKLIGKzTTzSQYrGKHd+ZLVorMMoWNYVuumJn4i86W?=
 =?us-ascii?Q?PH178Gxbe6q6wdWSf54rZ6b4rG6Tc2d9Bqu4/EhBeRkKFJ6HM+fIuvohnIQX?=
 =?us-ascii?Q?5cVNBpT6/LhwzOdPyUdARAmysLduByMHDYLyQy616DwyoALGKhrhncXhLBif?=
 =?us-ascii?Q?mv2uD7O7lK55OHikws5rHr0bD1maKZpb030j9Lyznk8l1bjA+LRjS5MrqumV?=
 =?us-ascii?Q?V0B/S7JyHA0XSZ1an1lTOZI/b4F6CvcoGeW8XJW+KGnmLB+d2iH0BxY+SDAH?=
 =?us-ascii?Q?1JhxoKGCJ+OEnPW/AG/rdXyMebRIQUQdUggwnIAvlziTwcsEsirfD+zh4n3X?=
 =?us-ascii?Q?6fuT+8s0SXZASjhpZoiJOyKVIijBfeSOUmER2rJrJbWXKfsRRTXE1FOKmZHg?=
 =?us-ascii?Q?2fcLxVZ5oxK4Jq7QQumoDTcVONWtbNz0Z7bko+I8wDhFyRGKCbn6AvSxaxGo?=
 =?us-ascii?Q?1GwQ1CE1b/Tt+a2M28EwHD9Vmo1GN0PmQ3QcErjkYX0/xzEsYYnbVP+EWMwf?=
 =?us-ascii?Q?0dcYCEBmFeCQgHWYEXixpj4X5gNvWhEFiwFFASLTf+gxhqtwMsInUM0ik0gW?=
 =?us-ascii?Q?qVNoK31URJMSlb6i4SDbDCk3WLMPo7UTsp1XmSSJOyMZ9H/TvJdXNian2+ZG?=
 =?us-ascii?Q?YND3priXvAnC4d2Vixl9sYW/Bj/x49Pf+6OVxEIGkmTVjA13?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a574c041-8a25-4e5e-d4a3-08dec2f55d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 11:27:01.7491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynbBc6m6v1PzysOkf9x/h5fkx2O9KYe9KV0x7lN5ly1lLVy+0kloEEvfxrNCSWuf1QbQSFCyiZkfBZ4NqWF35w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11183-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BL4PR12MB9482.namprd12.prod.outlook.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:from_mime,amd.com:email,sashiko.dev:url,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C8BD647B42

Public

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, June 4, 2026 21:06
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: sashiko-reviews@lists.linux.dev; dmaengine@vger.kernel.org;
> Frank.Li@kernel.org; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA
> DeviceID
>
> On 04-06-26, 12:12, Verma, Devendra wrote:
> > Public
>
> Pls do _not_ Top Post!
>

Noted.

> >
> > The pre-existing issues need to be taken up in a separate series.
> > The changes require separate testing which is not related to the
> > current patch.
>
> While I agree to that and it wont block the review but would be good if y=
ou
> can fix that as well. Sure affects your users...
>

Thanks for the suggestion!
I would like to contribute, in fact for my other reviews I have taken it up=
 for few of the issues reported. I need to evaluate the effort estimates an=
d fix the issues. These issues are noted and will be taken up in due course=
 without derailing the current upgrade to the code.

> >
> > Regards,
> > Devendra
> >
> > > -----Original Message-----
> > > From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
> > > Sent: Wednesday, June 3, 2026 20:15
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: dmaengine@vger.kernel.org; vkoul@kernel.org;
> > > Frank.Li@kernel.org; linux-pci@vger.kernel.org
> > > Subject: Re: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA
> > > DeviceID
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue(s) to consider:
> > >
> > > Pre-existing issues:
> > > - [High] Missing pci_free_irq_vectors() cleanup on error paths in
> > > dw_edma_pcie_probe() leading to IRQ resource leaks.
> > > --
> > >
> > > commit a523468dbe7999a5962895c3e0d73662a2938006
> > > Author: Devendra K Verma <devverma@amd.com>
> > >
> > > dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
> > >
> > > Add Device ID for AMD (Xilinx) CPM6 DMA IP to enable 64 Read and 64
> > > Write Channels. Adds the relevant dw_edma_pcie_data to use 8 Read
> > > and 8 Write Channels for the initial commit.
> > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > index 0b30ce1385036..4ba368d18cb1d 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > >
> > > [ ... ]
> > >
> > > > @@ -547,6 +561,8 @@ static const struct pci_device_id
> > > dw_edma_pcie_id_table[] =3D {
> > > >     { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > > >     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > > >       (kernel_ulong_t)&xilinx_mdb_data },
> > > > +   { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
> > > > +     (kernel_ulong_t)&xilinx_cpm6_dma_data },
> > >
> > > [Severity: High]
> > > This is a pre-existing issue, but adding this new device ID exposes
> > > the new device to an IRQ resource leak in dw_edma_pcie_probe().
> > >
> > > When the device is probed, dw_edma_pcie_probe() successfully
> > > allocates IRQs via pci_alloc_irq_vectors(). However, several
> > > subsequent error paths return directly without calling
> pci_free_irq_vectors().
> > >
> > > For example, if the pcim_iomap_table() lookup fails:
> > >
> > > drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
> > >     ...
> > >       chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
> > >       if (!chip->reg_base)
> > >               return -ENOMEM;
> > >     ...
> > > }
> > >
> > > Or if the main eDMA probe fails later on:
> > >
> > > drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
> > >     ...
> > >       err =3D dw_edma_probe(chip);
> > >       if (err) {
> > >               pci_err(pdev, "eDMA probe failed\n");
> > >               return err;
> > >       }
> > >     ...
> > > }
> > >
> > > Does this code leak the allocated IRQ vectors in these error paths?
> > > Because IRQs are a strictly limited resource, repeated probe
> > > failures (such as deferred probe or unbind/rebind cycles) could
> > > silently exhaust the system's IRQ capacity.
> > >
> > > Would it make sense to ensure pci_free_irq_vectors() is called on
> > > all error paths after successful allocation before enabling new devic=
es?
> > >
> > > >     { }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > >
> > > --
> > > Sashiko AI review *
> > > https://sashiko.dev/#/patchset/20260603143158.3243500-
> > > 1-devendra.verma@amd.com?part=3D1
>
> --
> ~Vinod

