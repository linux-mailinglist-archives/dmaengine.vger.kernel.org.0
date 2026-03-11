Return-Path: <dmaengine+bounces-9380-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOuKEXEtsWkVrwIAu9opvQ
	(envelope-from <dmaengine+bounces-9380-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 09:53:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D440425FC3D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 09:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60A0B31402B3
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0899A312825;
	Wed, 11 Mar 2026 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b6obB3IE"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D82EC54C;
	Wed, 11 Mar 2026 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218484; cv=fail; b=F7sHYcVg+IYBT/558WbTZxGLLKjsVB+wy5p4EX4DNFDRvyqRhYyX3oSEbfYdO9DGISdgzrvdnH6l4aFwvppsHJFNv/o1pJBB+sB3TmxlkIIUhjJ+S1+i0b4NrSQF9eIXsV+6Juy5iLb/q2YS/3lFlfrCmmiigu0Gsn9tRsZN1qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218484; c=relaxed/simple;
	bh=6FzK2c3zmiI8k0I5fSEMQF+D/rHnzHdqhQrDvQhgyig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUYNxtfetIPZxf0fF2XBlAAY9WQ52NRnddWf+x15K+OfL0b/GikZzDx/J9+33NSuILNpYyRc3FH8AEFL3jX3ynYzcBv4vDyQ5sUJapqBsdv25E1G5fk6QMou6KueTF6/e9L7gpcoVjgI7pBulCrBcFaO023EaLgoQ+TKi3m4fuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b6obB3IE; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXuEcfKnuFxv3R5g18JgzImgCioWXL7CqQKOlYW1e2bOadDqejuvYkBEhZYjF4Q7xdujUmnBoE94QxEOqDC8rWHmPKHicJpEmGpSqbioXcWdlTO9NcWb/H50gu+lXG8M3ea30CU27AeY+EofgI0yFFQcsdz/QFhAPjkKr97wyFiYxCW/2fC+QaaJsR4lkKzksrR6slggB/n+/XegSoMMAg6cXPgDJ+74BTPRa+Z2pecKJD47La8hDGivfiRKEivUnFRezM97YqNkFdvJoAYxP+cj+KSQ2cf2NnBHz0pUtNapWCpT8FijY+nNLa55pKZgqH/ghruJfQlHhN2izFmqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svfT9XX/fVv3gr3AiLoa5CVkCFq2WzZyZqI/VsFbG9A=;
 b=CdNzflfk0CATDnWTDxqHZo6yLtHQ7IqdCGr7ONosDGOlgA15HS5fcXQoQg2KY60fa2yCA8+XZirZzMAAq0QCX77TPqYz+LEKhu1EeiaENDc/++XY48HTw+0yxI0sc9cI72UGgSh1sIsMfAdEWajYqgEVMNYR2JU33Ya0LKg9KDXaSo/gdlD0TXWBvBL9DSYBr+I2w28aa0y3C1p1z3xUcUhCWV6rX+sTr+Ek7g4BTmhQ8Ux/nmM3bBixEKv6spT2F8wg6J/O6AStNb3vTDqIsmECEOPmuZDGCG1WZTiTn7BLCYOzeV9B10uo0rF923mqbx0ESOiOBKfFlCm5bdoWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svfT9XX/fVv3gr3AiLoa5CVkCFq2WzZyZqI/VsFbG9A=;
 b=b6obB3IENZzidmdJHfDZ/+RLh7BWx3NMOEcvkFQ53sgfedHhmSCaAbsNwpC9acu3F+TbANOBow+InpGst8ONJBxHZcO7iLx8kgFbH8j3wQKtZm87d95YtZ3NCPC9ST/8YuJ4piFDl99XIus7rr+17RyUwL9qNOMpvArqgum9tkA=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Wed, 11 Mar
 2026 08:41:18 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:41:18 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v12 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v12 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcsInMhAVcni/CFkCmDzuUvNk127WoLEmAgADWPvA=
Date: Wed, 11 Mar 2026 08:41:17 +0000
Message-ID:
 <SA1PR12MB8120F936D502F8EE9FAFDB869547A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260310123055.2863727-1-devendra.verma@amd.com>
 <20260310123055.2863727-3-devendra.verma@amd.com>
 <abBrex-33Ot5Kdqh@lizhi-Precision-Tower-5810>
In-Reply-To: <abBrex-33Ot5Kdqh@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-11T08:40:58.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|CH2PR12MB4248:EE_
x-ms-office365-filtering-correlation-id: dbe3b4fb-f8a6-4ae8-c28b-08de7f49f6a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 5Re+biFMO//d4mA9JL1keThzi6IJK5mSuOeuhSkXOMObyrdwoFDvgtK/PUYJaYSmPoaewDCumFGAsPNvUzQQV4HM/ufdqyrr/8PAiKmI8oaeNb4OVfV2V445pjY1LRvC6TG8NuAGiWtmYmowB/aRmI5lHD9xg5gpJAddNLAEodLHDCWI2B+aX51IcZkirQMZfMDh0P7TtQyY0iLVbnKYBJIFrPJ8eEdNPj78Yo1DqudsGSYAhw9jSEV4aWUJfV0HowVwjc55+Chfcelhh42o7n1qVgBGThI4+6eIuLX4m8z3410dcnBvn9oJJKqXuIKHyIzz5ZZG9p3yZUafbEtdMcTLL+WefJ9zjKc1dIwfEeB+N1d9oEnxgmpTG4zo4gbsyuzOcHU6QA8izSt5865Ydq+CRpZGsCdmgmnIiDgQMdAiVz1NpXi8OR6A4denOM7dkkSkapnrTSIr33SEQ3TjEmYMpGy30y+eC34ipj2EauA3ITHi2Jg4MxUY42Qf8B6DSjdPqnHJqPadJEwim/ygHLPlPgJhxjPfL2A6s+YuavNZjNx8maY8pp0uDgNEl7x9hBR80q2HCiI+ttqQipPlqkXCiws59uVBj+RUd0T2f2Ll9Na6MVWVnajROg30A4YfrIsy8bQPcDq1C4gt5rF85pStHRy9hdHA+rMXBqjgIEeyv6b1qLe9YSp4T7eNLqLjqgu10oZonnnsjI3/dYAXcOxmM0kdAT7VRxM5JIpdMm9XAG/PulxhCAHO0esCoUxFdE4wdzwIRbVucmvdj3XJBcSj0U/hMTe5lSenLZmb1As=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5uPMYLD7K1YnnJQ9SGyo0ba7a/6apYV7X5VLfpiF9B/L4EpRqX1L+p0Ix5GF?=
 =?us-ascii?Q?iVJuAc/ahYbuOksNK5PhbFYRfUFsj/Zkpf7FqQQ03M4B4xY0E4wlKi31tA/f?=
 =?us-ascii?Q?55lZuW8pUSoR6lCmykn9K7gVdkPYPRyoBTcEzmnkdK+rb14tGTPSQdDD/pRi?=
 =?us-ascii?Q?BHJtlqdKqxd92IREfF8e/ciI+J9t+HYOdBPkMDeLMhpkBHAV3MaMjomnSaIP?=
 =?us-ascii?Q?6AaVxSdKOVjhFtVC/YWNshraPnzBuV4pBcNXHqZPlbOr1tXsimO4TRJrx3G5?=
 =?us-ascii?Q?gINQ9pcBea19VPhCzNTmFDQK1xxF9j2bOeAIg2yossCb7cxbC6hOXrpQsCHm?=
 =?us-ascii?Q?8lrRoo0ax1QM+BDS2Gzxb12to1AyzyxT7XhTi/P7xMnkKhjvHwMk8oEOvB3A?=
 =?us-ascii?Q?DFgOwwDSSdN62UVxVsgBFzWTFijnaKBajzQNkxk7W4Kwy9Zr5k10ctkfsjEg?=
 =?us-ascii?Q?F7NfeHBdaRRzEa0/eNqZ8PO/3fNnybJS3at1rXf8X7V1BJpfI1AinOFw+J+a?=
 =?us-ascii?Q?r4K+PvN72FOICCuZ2G2OzRyj68bGRKMRjrcpvR0HU+Z8vo45P5NiQ+igsb5k?=
 =?us-ascii?Q?EUB0iF6nEsT434iqMW1bvd7g0/Ps62ixYuYafw/iMdRPI8WuhUq9L/vZfOlI?=
 =?us-ascii?Q?qhaV6als4JegO75q+Vhsc4oA6Cmm62zicLQPxExr616AwoUpCuZ2lXUhCcCw?=
 =?us-ascii?Q?jW8E1i07upUq0S4ZSCGZkI9Ceo9HnpSurltOogPaghYyr3ZuyYp4W0q/rLsj?=
 =?us-ascii?Q?lU/LLzyaAa7f33KIr7lXP7wWB4SVjOx/w9B4sSFRqcCmihmgovmmroCxoJxZ?=
 =?us-ascii?Q?lJZdlOPwG9IMlNppMitx6VGNmzGwaVzqot26tGH29ksJHGM4lR/84QOCSzkv?=
 =?us-ascii?Q?5kOTLWr79G9Oo1iJRIPzzdPnNJcmOfTvkj2pHgiksoObHFEZ4dikc9bybt/O?=
 =?us-ascii?Q?4yXvtpTRFXcz8Bur4qkfA0IQ/UqXH5NgLNl4C2FFQEPnxZJtE6n9l1nr/XPZ?=
 =?us-ascii?Q?5wscCsDEGkp3ynTMkfqOJyTA0pKjwyW2A5fLYuNL0WZ3/XIN6x81JnFTRF+p?=
 =?us-ascii?Q?JdTXDN+1Dyfq7IqJS0eOguFs1sN/O8IcIGAI5PrmTHBZ6RAvNxv3N+GlXG3n?=
 =?us-ascii?Q?L5xR/tre6QFteoHm2YmOgO5hhR2UIO4L+N5DeHxmrcExmtMQfaE5toxEGc0j?=
 =?us-ascii?Q?7xVlWiwhO3b9x0SpHfljNfCZSyG0bKHJGh3sOhZuK+cqz4IMKpKFEame5bmu?=
 =?us-ascii?Q?KLvx+Vz5W6JX2HOjC2PAsx4RXszzShKUQAVVvUkS05q3Rr1uxlI2+8BZ1A1t?=
 =?us-ascii?Q?/65AMjaTHWe5KOTkSDd9Y4EjQB5MT0biJRuisLhuAVS3AcITXlIwkbrksUFV?=
 =?us-ascii?Q?QoY1oiiBTsKtmRp5GQ8yrkVquxWybX3vyAO5o/NxMXjDO2HM5nWa9X84an9O?=
 =?us-ascii?Q?WUgmRh63oTeDpR25MEd1y5S4ENQA1/5fSaqooZaeFqIoJuwr22m7bbHGlqjX?=
 =?us-ascii?Q?2ORvTiU+GxLweqp3Wf/t+uTRc0KOpyJzd5Pr8ZfL50kWzCjwMqW+clv9gJGm?=
 =?us-ascii?Q?8aIGLC+fugm+zkRmCJYY3+PkFE4ZoGwk+j5i3tmTlfno9EKMBa4c1xmix8el?=
 =?us-ascii?Q?7WtpiiXZDhQeNr74dkG61ljYPBWYaRhDymRR2Hr2RJFPHXRZD4IPiEqfZJ49?=
 =?us-ascii?Q?e16401QtlPaTRS68m1kTb/ZzRQMc5Vor5snE9+ilcXLtyn6x?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe3b4fb-f8a6-4ae8-c28b-08de7f49f6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:41:18.0213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQg5SzpC+z5gWT0b6AKLR7Pk7Tm/YPGbnhug3UdBVChwTyayPNcwkyx21ycOGoIlbnYFyDbTdCVGeZRe1NkcJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
X-Rspamd-Queue-Id: D440425FC3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9380-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Action: no action

[Public]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, March 11, 2026 1:17 AM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v12 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Tue, Mar 10, 2026 at 06:00:55PM +0530, Devendra K Verma wrote:
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
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> ...
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index b8208186a250..f538d728609f 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -295,6 +295,15 @@ static void
> dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> >       pdata->devmem_phys_off =3D off;
> >  }
> >
> > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > +                              struct dw_edma_pcie_data *pdata,
> > +                              enum pci_barno bar) {
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > +             return pdata->devmem_phys_off;
> > +     return pci_bus_address(pdev, bar); }
> > +
>
> You missed my previous review feedback about create new patch for code
> restructure. But change related small.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Thank you Frank!
I think you missed in the mails, I provided the explanation why this reques=
t was not taken
up. But you can take a look at the discussion happen on the following link:
https://lore.kernel.org/all/aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810/

Please check for the string "Thank you for your persevere."

I will issue another revision with the review tags collected. Thanks!

>
> >
> > -     for (i =3D 0; i < chip->ll_wr_cnt; i++) {
> > +     for (i =3D 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> >               struct dw_edma_region *ll_region =3D &chip->ll_region_wr[=
i];
> >               struct dw_edma_region *dt_region =3D &chip->dt_region_wr[=
i];
> >               struct dw_edma_block *ll_block =3D &vsec_data->ll_wr[i];
> > @@ -410,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               ll_region->vaddr.io +=3D ll_block->off;
> > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar)=
;
> > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      ll_block->bar);
> >

