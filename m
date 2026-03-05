Return-Path: <dmaengine+bounces-9273-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPLQByp0qWl77wAAu9opvQ
	(envelope-from <dmaengine+bounces-9273-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 13:16:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B173921172D
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 13:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A76730CC7B6
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008339A805;
	Thu,  5 Mar 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oHnBnCpI"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7FB39B4B2;
	Thu,  5 Mar 2026 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712947; cv=fail; b=XnmfRtkNdYDUnqtb2hCD/Y8HzNPS84qrH+iFa6xNyxWn52N4uBPorQ7Kb+AdJ2xN2bs6305qY3s08qNeajQ5fTfL/3K2xP6XcFoCRZkpSr1YZwhwIkPqthsbMP421fRxseReJ0u0UHnuv1CY8RGOAjYEnsr7DmQ8Mj6Ze0mY7W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712947; c=relaxed/simple;
	bh=K8CxyaF4n5UqyfeRuxmmEZO/x2AkKMBgjdnBnr63mo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mkglzbeORYm4ymBY5yEqjsQ7jmLr0IOKJpk7O+8P2DTuScqsjIHEDfaE0EzcAEYjT514+Ob23GQf4QBz81TCFvbKy3rBh2sYhLvCle1ysHv7a6vAkbyHXUGjfeMdmmy3cC/rABWZqPj0mXHos3MhAuxgKJgrX3Pat9R1W2InzQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oHnBnCpI; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnNX66XjUldA1FLLaoufEfe8EkXpJ7jGHgLurs6QzrZknxuTq4sBXg/p4+NESETZMFXg5JKrkaaTVqFqu1WTr94yB4r4FJpQGXNEP6727tgdbGuS1k0BqUoIWrXdVzasgN8Y+SgXrkWyyXmQhBdEeQm/QLdowJWA/gSvvgUxyhfA9ajL1vckGLCECKy2rwCs2wUHuVHV1tNiXV20OucTXk/MJDSZ/zaa8szxRScElC3JbknyM0KKTVY7WP+45Qzti0iAwEjSgLO8UUvoyHA9W3vg8yzsygsNWiFcwnxHYoASnOsVQD9vKFSkxtrc6qWiyxj5l+ZPX98IqsYRpmN/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ktaAu0pFFxlXj/FylERZqpwBAy7Tnt8Dw+D07eCe90=;
 b=FUMbCGg6+ddoQkuFGu3WUfFyymp7RMQBkccR9s+/dYoItL81yvQG6I0wC8NDbjTR/iz1ARixUf0UzoeYq/UrEt2xOBjC+dA0Hl+qJ94QA51OSDrV6Ry6g6mp0QCqMgP5gLSptNBY2OMI+ApJqzyZ1FSdpCK87WQZ17KuxWVYjD8TfLNkw5ZqwnY2Rw6P+o9wNPig8l5gq7Nr2tU/DvIcmr0oc1V9r7o5c1EPzPaXiDRBwzbVfxRsdXP+ZjEMIBI8dyLys7syR1zpcpkp03wP0cQqqsfWl8IHkBmX/0cCtWi/rr5B1F/vO6Gx/jy3mu1h23EvicXbYdOy7dFXQuiJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ktaAu0pFFxlXj/FylERZqpwBAy7Tnt8Dw+D07eCe90=;
 b=oHnBnCpIGhWrYfZi8urg9nsSItEcrU3EHQvVGFkumN8QDnr45szHMY7hZG/POxymLeC1jrFxb4ITxEiQyJ9142ITze6B9dOAKLl+XG6QIdRHZpBOAK6CfqO73ne2tqoeGV2jbGBlMJd7DwLM5tFspfYyyURp44AtNbsHtaP8f/c=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Thu, 5 Mar
 2026 12:15:41 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 12:15:41 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index:
 AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXCAALfggIABEsjwgABxvwCAAOnmsIAAvjoAgAEKjvCAAHWzAIAEwNdwgAHz+ACAAMV0oIALcI6AgAE65FA=
Date: Thu, 5 Mar 2026 12:15:41 +0000
Message-ID:
 <SA1PR12MB8120CE2DB5EB97512E51F76B957DA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aahkKZ9EBwWfwy95@lizhi-Precision-Tower-5810>
In-Reply-To: <aahkKZ9EBwWfwy95@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-05T12:03:37.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|CY5PR12MB6297:EE_
x-ms-office365-filtering-correlation-id: db1e5f95-d8b2-4501-9be0-08de7ab0eb4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 ij3ox6M0/HbthNbeXDB9qfdof7EgKhhrTLzIsWiPta+9fkVAFIWIhc8lNG0YL7y2CXd9YNagre8a3mDBef0gkSeyi3Ybwm4+wou/2Q3vQfqGqqAJeT9Z3VSXy3pDSNSTdtoFnKYaO27dXoSrhst7gxVLmXnIS3GinB6Yalnb5LtQOAEnFTJSWweLcnn/zYlj2ZU4eZu/jJXBd73UBxJViIZpmVTmdiUsKZfCDrF0Tji7cxrrjdBVhabXUjPvVs100TyKRUy+uVH+VlQOvnJeD+kZSdZulc2oHfN5ntfrpUH4LVo7yux5cklk08zKuFsVYyvZ7YzbFst4DhONmvTBoaKCGswReBQOIcJZEsNkqdfqFsQxX3hTcUo07By3uF0YLxoFwiVglk8vZL32gJAYWLcjOCyM3NCK93oZlPotB8tVD5yshreX4L9RZDRaNOjU3dTcnw8lz13mTJU8bzJKKdd8UpDmK0ptLEGwPnzOUrnGRMM2/Kr7ScT9c13CAAsacvYrghqULveF0UTvZcVqPp7GwzE4eAMgt2198/EzIkyB8M6D80+D0dwwgCg/k12XxTnfAXhIetqJf3qdx16Ua1rJYTW44ENLoTdusjLpG7bM4zXzTmEl0d71olxI8/uhFx3meIP95lWhHyhAsOo9TPT9eXi0eq0oIoNLYq+8wyCtxDqi3zRzXodJEAu9uOjjnoJ63H1OhJdOgIaaL0Tz2RRUt2Vt41p+Gt+gDbLtf6xq4svpLPr+3+GHI8HvZkQqCAbv9YEne7i5BcrLVO6zkWiu3HHa41UNIdayrY0T084=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iKtO/Ax5MWJ8sqeD85dXUVfqHsbL0LTXbCPCuNJ175mk/zxgQRsShvfb6jQD?=
 =?us-ascii?Q?8nR37TAMEY1NnnOp70BWXuWtgGYm9UhhMTpmcjJlamd+RDSk1ZBnyuVVYeLq?=
 =?us-ascii?Q?pWgkAejqwY4SjhEYuHlcPiYpqSjB2YEPTmnabIGTRAfFhjCO4U8AR+EO2pAk?=
 =?us-ascii?Q?6mr6UbYIAtRBxFG/pOq1pRPGEmllDj5B2m+lrkMertooxTLD2afhpLxhKuCv?=
 =?us-ascii?Q?RagzeHe2zaBTekwAqAG4at+wFd/e/xAEZP2zNoyc7Q0B5LM4rrytTmkgldjI?=
 =?us-ascii?Q?wQMzQbqjcQBuUfoP9wFd1oJM62dlOIHxs7wdvhIK8/H8xLha7rscKVu0/g9R?=
 =?us-ascii?Q?VSOXJ26+reRNIDrzC78gqqh1vSPfaBimgkvcIc3PgZUxB91CY9HJ+Uth0kgq?=
 =?us-ascii?Q?H8P0vdeChAK6xZNNhxbl55II/pDNzpM4YL73duxRCgc10d4jEFeMk1WIKVSP?=
 =?us-ascii?Q?ee04rPpxJb82F1IVkuzkIhm2p8Myns0oOd2h7muF2WEP5pYecTGycin8YJoH?=
 =?us-ascii?Q?nFRX/wZhQJHgsXUhgsCIVPll73UaXH/YoVjKpwfSYECPrt23mTgOMcqAdUMG?=
 =?us-ascii?Q?fXJs3l82JOm1hpdk3lNpTq0h4MnDo8SO7HyR/0QoUV9ZGLS0v4dpgUr+aN7n?=
 =?us-ascii?Q?jtD5vqlo0D9Bh0Pdu8PYBfkYxE044uOy5jj/GSJOk2a0m2g+JR/oXCroy+Kn?=
 =?us-ascii?Q?zqDzG+gQqiAhW9pjaTJbKc1j1TmE4kTFNAHh0lbbf74nTurgeO2yMAMmevq/?=
 =?us-ascii?Q?f0qw8Xw7eLAWO/AHRmtvniAZSntvYU/FnR67fjbNzSOP3WsjvODxnsB0VexK?=
 =?us-ascii?Q?kCh9dohSB59vNFYL6TeIHob3Ttbsz1jULV20Pk527lSlVs6mHTWU8d9bFHKX?=
 =?us-ascii?Q?j8/uv9s/dVjYc2aMwSdJS4QYswELW7DXvVQ/Zt/BV6tZEo6NpEpkSBLaurOf?=
 =?us-ascii?Q?rDyB0YiP9qDQdyXI+FzIr1bwxWIj5NyBjgbrhVyLTjdIptw6YJ4z7ACvuJM+?=
 =?us-ascii?Q?gDXTMqgVcKxyTkY3zAu60p7fwG/+LlDVldOSbZIYNA9VK505gTSAdf1XujlY?=
 =?us-ascii?Q?fT0WoKa6UNILm+zaHxR0orcF0UA/2yAM6cZo6xYeHYlYCrHmBvE1+rHfJ6t3?=
 =?us-ascii?Q?JhLdidYYKP9f/064inhMKySOsgAdESKsABWfWujuKnESkpsnnIoHmdLEn+at?=
 =?us-ascii?Q?6vBWwtt/7W3b1T0qxgOlm6d7BfALClV2CIdBldWkBSjan0/E2ucVT7FeAK5O?=
 =?us-ascii?Q?PZw2TzPoM3MUGRy3UhSfpku0CBAdcDSeDVdVunCfPk25PbspwvHf3xrM7SIl?=
 =?us-ascii?Q?xSUXphugxxl9Syf7ChvFgUYqOd7MmK7sLU6fNLgEw2Xw+2vkGlXu7Fo63R4e?=
 =?us-ascii?Q?lIINe3Pnlp2+9o55QgMnnloV1uLxKvxj2coOZ8PSYL5pv1JaKMKrbIwHqvbI?=
 =?us-ascii?Q?CquT7hnMcOAjlMcvgXuhf689lKDHFJqoFA5kdu14evaqf6kUsk0fatjgsjHJ?=
 =?us-ascii?Q?cuKIz9kdp5HGTzT4qWRS/Qk79WYgCIr3L5VCHEitilOrpvDOb/aTgfsfq4f7?=
 =?us-ascii?Q?bm73cIIh9SOY+t3BtnkYziVGxW0y4reMMFOk1yubWk/TXdAmU8QgzgNp9kOx?=
 =?us-ascii?Q?jRrZ0WL1YJgK7znVbQcVdAamzXt9D114QAT/KpgE9ldPKCLZ2NY+ACxwPzgx?=
 =?us-ascii?Q?1s40pwyAnbC6qvVzQeDeX1IsAa+RsEipdRKBQ2tD97zc1ZcV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db1e5f95-d8b2-4501-9be0-08de7ab0eb4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 12:15:41.3441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/JEXnd6Clhq7V5ImIhvOCPG4+OD2LCE833rOAsO5hcVDkg2doDxdyNPIF8gtjpuaxbnVtKwIj6sJzSkzP4dAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
X-Rspamd-Queue-Id: B173921172D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9273-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,amd.com:dkim,amd.com:email,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Action: no action

[Public]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, March 4, 2026 10:26 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Wed, Feb 25, 2026 at 12:06:12PM +0000, Verma, Devendra wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Wednesday, February 25, 2026 3:58 AM
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > > mode
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Mon, Feb 23, 2026 at 04:40:07PM +0000, Verma, Devendra wrote:
> > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > >
> > > > > -----Original Message-----
> > > > > From: Frank Li <Frank.li@nxp.com>
> > > > > Sent: Friday, February 20, 2026 9:33 PM
> > > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add
> > > > > non-LL mode
> > > > >
> > > ...
> > > > > > But if it about writing a new function to check the LL mode
> > > > > > support then I think the current variable is good enough which
> > > > > > provides good readability and do not create any ambiguity
> > > > > > compared to the ll region size
> > > > > comparison.
> > > > >
> > > > > It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip.
> > > > > So we add more cap flags in future.
> > > > >
> > > > > Frank
> > > > >
> > > >
> > > > Hi Frank, could you elaborate what you mean by adding the cap flag?
> > > > How it is going To help identify the overall chip state?
> > > > I do not understand what is being implied here.
> > >
> > > non_ll in chan means current status, which indicate one channel work
> > > at non_ll mode or ll mode.
> > >
> > > here dw_edma_chip means hardware's captiblity, indicate if hardware
> > > support ll mode.
> > >
> > > Distingiush hardware limition or current working mode.
> > >
> > > Frank
> >
> > Thanks for the explanation!
> > Hardware supports the LL mode / non-LL mode, just that there is no
> > piece of code available which can perform the non-LL mode as only one
> > mode was supported initially by the respective developers.
> > So, providing it as capability does not look justified as in any
> > scenario hardware is capable of non-LL mode. Theoretically, non-LL
> > mode should have been the default mode.
> >
> > The non-LL mode is not a hardware limitation either. LL mode needs
> > extra configurations and in the absence of that, interpretation could
> > be, enable the supported other mode which is non-LL mode.
>
> Yes, that's reason why I don't want to add non-ll in dw_edma_chip, which
> should provide hardware's information.  non-ll actually miss ll_region
> information.
>

I think, non_ll can be interpreted without using the ll-region related info=
rmation
as well. My view regarding the dw_edma_chip struct is slightly different,
it does not provide the hardware capability rather stores a snapshot of
configuration based on information provided by different means,
please take a look at my comment below related to this.

> >
> > With the current non_ll inside the dw_edma_chip, when non_ll =3D false,
> > indicates It supports both the modes LL and non-LL, but requires user
> inputs to enable it.
> > With non_ll =3D true, the dw_edma_chip or the hardware has no choice bu=
t
> > to work in non-LL mode only. This is the interpretation for the flag in=
 non_ll.
>
> we need distingiush current state and HW/SW captiblity. in dma_chan, non_=
ll
> means current working state.
>
> but the same words 'non_ll' in dw_edma_chip is HW/SW capablity.
>
> dma_chan: non_ll       means current channel use LL OR non LL.
> dma_edma_chips: non_ll means only support non LL mode OR both.
>
> The same words "non_ll" means difference. We should try to avoid this cas=
e.
>
> if you want to add field in dw_edma_chip, avoid use the same words becaus=
e
> their means is difference.
>
> Frank

Can we please simplify this interpretation, the non_ll in all the scenarios=
 should mean non-LL mode
only if set to true.
dw_edma_chip : non_ll =3D true, it shall mean that all the channel, at chip=
 level, can work in non-LL mode ONLY.
dw_edma_chan: non_ll =3D true, it shall mean that individual channel is con=
figured for a transaction in non-LL mode.

Above all, a nice comment related to the flag shall be good enough to make =
the understanding clear, at the
places where declared.
Since the beginning my emphasis is that 'non_ll' flag should be treated for=
 what it implies, i.e non-LL mode.
It was included in two different sets of structs to show the hierarchy how =
it could affect the overall functionality
depending upon where 'non_ll' is set to true.
Coming to the dw_edma_chip struct, I do not understand why the dw_edma_chip=
 struct is about
hardware capability, it is more about the configuration of the chip which i=
s filled anyway at the time
of probe() function calling. This struct does not provide any capability in=
formation at the time of probe() calling
rather it is filled based on the params configured by user either as static=
 info (eg: snps_edda_data) or by reading
the capability registers (eg: VSEC and channels enabled by reading config s=
pace).
I hope this clears the doubt. Please let me know if any further information=
 required related to the non_ll flag
Interpretation.

Regards,
Devendra

> >
> > With the capability, would it not make the statement, that if non_ll =
=3D
> > true, it supports non-LL mode but that does not mean to be mutually
> > exclusive and not support LL mode at the same time?
> > If there is a requirement regarding the capability then it can be
> > taken as a separate update but I am not sure what purpose it can serve =
wrt
> non-LL functionality.
> > Please let me know your thoughts on this and lets conclude.
>
> >
> > Thanks!
> >
> > > >
> > > > - Regards,
> > > > Devendra
> > > >
> > > > > >
> > > > > > > Frank
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Frank
> > > > > > > > > > > > > >  };
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > > > > --
> > > > > > > > > > > > > > 2.43.0
> > > > > > > > > > > > > >

