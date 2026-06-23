Return-Path: <dmaengine+bounces-11752-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wYRRArWFOmrb+wcAu9opvQ
	(envelope-from <dmaengine+bounces-11752-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 15:10:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E16B755C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 15:10:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=q0o5UKJo;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11752-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11752-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CAB4302D5CB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBBE2D77E6;
	Tue, 23 Jun 2026 13:10:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA61218592;
	Tue, 23 Jun 2026 13:10:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220210; cv=fail; b=UdU5JOjcOgXamQ7ZIp6LKJkIUf90qwIP7QZNuKjrVab6eLLc+c3dkIXEawg3OuQ4SzMETifxrvBbHU4ouLbDLkVUnv0cNYbZyxf7kKdHdmSaH6MECgDOV05yQs6YPRZp+f6LkcRHhPoxaXjGC+If9DWC5PFYBqAeBzEr5Oi6RSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220210; c=relaxed/simple;
	bh=MZChQNxeuspVWtGnzaZEyqjAzDcJ84g3NDm/gfsL/6U=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I5Bf/YmHasbfbVqnJ4n79MXn/UqHDk8aKqlaC3rRhH6u+U89Wc7M9WzDGX99lkiB2uSNex/Dwi4XQiCCT3bb6dljKyRsY7yOC872ol0euSzBTC+425RCa5E/wMci5gdhhMFjXkYjekwFZz7+VjhVq8ABt4V4Qw3i2DRhQ1Onqj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q0o5UKJo; arc=fail smtp.client-ip=40.93.196.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boMkIJGC2ywO1TSru6ooQx1wh6uctfw4FqKiDf045TIhocninq5B29+10fhd71g80+JYFKgI4nugbosXRpUJf5hhAl+EOvSgMreIgMOvqU9jbSJRgjC2qu/t5EbRu3iOxrvWAClleqVF/V4Yt68VIwUiYaNyxqOF5A5Vbz0+rOco/Wa5/NOAW6gxKnaPRfTO8i6WC4Cv5GcNhbPYael/fjUyFnbrUS82oOg+YYs4XczuswgzgUFCI+OKnZr3MlPjoCmSf3Iz82cJYzFwyMBn9Pll8j/9DBE4yoUuPt4HOwgJyIpPDIQtpWTh86Anr92cDqUHGS2ak1cHLKmYDs/QkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VGMJJafq34r7uGrXyMXp/K+eCrbieiZOz1ZTYRcEN8=;
 b=G59zaEDJHkJf4tZQ4MPFED7lgOit3kRSZreMTKuL7ObqhdH6mF+7UGg90bPBgtdgZNECEaN/zlHm2ThyeJhCrP7d3oho70TynjEsiT8Ti5hPRoY/vVIUJrXgUK9hYqeMb12WQcMuy1vhQK5XyjKax+AG3ZlPTWLf4Ed/IfFllkwHj6PkuzhxaST1c9v/VCWsyV8LlAVYeC+Y0sm5z76pah5PKIUaJsHyXtcQYuZHz/rz/3DC9HYmW4BmklTKtN0CUX7rwD1rVhAC6X9Lxv29yYDFE55AOxDlM4IVUG02dTU9wtrLlVB1H9+D2p+K2M5qlmt2Wj1Vl7nlkiI5vvOxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VGMJJafq34r7uGrXyMXp/K+eCrbieiZOz1ZTYRcEN8=;
 b=q0o5UKJonEvcVxfOUXkKr+nxrvCR6Mb+o4jtzq/5npKyzamrT+tch/1CREGDykJ5q7qbOk0a87IVP4zt/qmN7oMOXyhY5klKxPX4GmU6suruyhc5ChuL2pkMX+oOSfLfaBcaUlWrpUAruguVzTaGERGD4zPbbd7e1hs94qa6U6w=
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 13:10:06 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::61) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.7 via Frontend Transport; Tue, 23
 Jun 2026 13:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 13:10:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 08:10:05 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Karim Manaouil <kmanaouil.dev@gmail.com>
CC: <shivankg@amd.com>, <Stephen.Bates@amd.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: SDXI on AMD EPYC (in relation to =?utf-8?Q?Nathan=E2=80=99s?=
 SDXI dmaengine patchset)
In-Reply-To: <20260623103204.qvmd5luse4vmhwl3@wrangler>
References: <20260623103204.qvmd5luse4vmhwl3@wrangler>
Date: Tue, 23 Jun 2026 08:10:04 -0500
Message-ID: <875x39ies3.fsf@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 920114a0-3870-4718-4ce1-08ded128be9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5WTOZnhjDxRQGMgEmq4xS03UusxtV4TcW4qf4IcKH4cgfIuYF+K3ydYkz7FGPxzf6A8s0VVperoMyj9RP0hmQVfMzaJ+oREAyNJi2OT9NMvY24/VVQEID1wxf/M0kvnhHIOWNA9jhS2wNZS9ErVHPKVxk9y1Ju5jy2iK2ndDc4CUwGIcdY5zYTzkJ5T5zh2QnI/CWsVjf0IqSfhSHYP1tDSoKVFzwqclc+wn/hTzTlzqCoYOurK1ETVa17JYeUye1iuNV3WdUX5u+JrK8/M26OYhgLL95tWmfmvvIij8bjypASdg0j3EVMDTw+hLDhwdF8hnf48ex64WU00pIa5dTM3fuxCbrb5GDxYkW1VsoOWHyO91WlNlUo9EHc/XQWxDY/RfTQ0dLu7i8X/KLSG8cdsl3in+eytxEafvJ6Nk4mZrKD1ItNxOp6J5w3EdigQ2GrbsgjyVQpM5ZQUrTxZvmeFZpMy16+ShdSxBwQRValMfwCNnbQNYb6xe3hHbOF1DRv0ZuqpNuARurR6aOjNSDRdyeh01bXYhNWnHLWCARXsdvwTO0dh90paiIsslAdZpPZCMwUeAPJZPH/uJe97ZTneR4rp1VFOsQ9IxU7gbC7C1RLhzAAY+gdLgJa9kx6fg5cTWPKv+HKzixuO72WzqfXeJmNdP3itgVgaeQi5TpoU5iGZbElZQYWF9vDseWyJIFr+vEvD82piWkMWP2qwdUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jzh9EJ4D2x2J4k1MVSLHWgOSldolUj1Rh0BbBlynRjFbE7ai6n6QAVHM4fra8I3bNLZDGWpUxA14LqXdH/5+9t/m87SD5fauybkBYjTRI0T/KkiXbZ53ceKrh4hjl+wm+Wt9r62Ctxqaha94IxtocfLtCsbHzP2O2/nidfUCWOs5obcAJy1yYnPKQggOFZYFDMUBUx/qPFDqh7wFTsidPLeX+SDCgnyl5zN/Y40IVG4vBr6t632MUOvhaZQV+unPLb0OwJksRXj4GNU7bJ49unBUveF0GumssI5SLqEtqVJ467NTR/c5qceail2rEiOKJwLYIzahRwfTJrekz8mg82k4568AzuqEDsQjPzegkzs0lTaVKwwU1DaSkUFaemrnGGpEYJEwt84QeViKqTzw5VMHqLw42TbDCBoK7qRc8qskdGfY4wH2AWerZHAlxaK4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:10:05.9091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 920114a0-3870-4718-4ce1-08ded128be9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11752-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kmanaouil.dev@gmail.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:kmanaouildev@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 919E16B755C

Karim Manaouil <kmanaouil.dev@gmail.com> writes:
>
> I have a dual-socket AMD EPYC 9004 in the lab (I pasted /proc/cpuinfo at
> the end) and I wanted to see if I can get the SDXI series from Nathan [2]
> to work on them, as this will open the door for me to experiment more on
> AMD hardware.
>
> I don't know if these CPUs are equipped with these accelerators or not.
> lspci is showing these devices (four on each NUMA node):
>
> # lspci | grep SDXI
> 06:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> 21:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> 41:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> 64:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> 81:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> a3:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> c1:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> e1:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
>
> All of them have these PCI specs
>
> vendor=0x1022
> device=0x14dc
> class=0x088000
> subsystem_vendor=0x1458
> subsystem_device=0x1000
> BARs= 	BAR0/1 512 KiB prefetchable
> 	BAR2/3 512 KiB prefetchable
>
> Class 0x088000 is:
> base class    0x08  System peripheral
> subclass      0x80  Other system peripheral
>
> However, the PCI device class does not actually match the class from
> Nathan's patchset [2]:
>
> +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
>
> +static const struct pci_device_id sdxi_id_table[] = {
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
> +	{ }
> +};
>
> So these functions appear to be exposed as generic system peripherals
> (base class 0x08, subclass 0x80) rather than as SDXI processing
> accelerators (base class 0x12, subclass 0x01).
>
> Do you know whether these AMD 1022:14dc on this platform are actually
> SDXI accelerators?

Afraid I don't have any information about these devices. The driver
isn't intended to support them.

