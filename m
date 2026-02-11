Return-Path: <dmaengine+bounces-8882-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOBdJOIyjGkAjAAAu9opvQ
	(envelope-from <dmaengine+bounces-8882-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 08:42:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE38121EC3
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 08:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2743301413D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BF30FC03;
	Wed, 11 Feb 2026 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y8XG0X37"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96594AEE2;
	Wed, 11 Feb 2026 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795742; cv=fail; b=VLHBMc2ZXB5hCjyOX2tXcFl6N1w/wkBWUYG908PWgomU4SFn4Uip+BHWBH7/U2N9SGSxIsQrXkVaE1zWqVaSavIN3aYtmngz7vQxSuvYiqY4JC1UmfFkoT0+rJLSEk22FF+AWBMdPheChu6zCVhFNe8VdS40PHjIf2wff94RRRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795742; c=relaxed/simple;
	bh=8vKZDtLiPYag1ZYDYxCj/2dXMgMiCfZXaqyZSsIZDEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MhtM5A3L4FES60hiHYtN6D5ZUN4q8d70Q3ui2KH6gSN4Od6VQWT0BEOX2ET9ApGTB29X61EQ0jX0MBq5gVUOtlyUfO0Nbak4HwxClYhQ6d7O9Qdu2aOP2UEzDbGv16T/OEHqY8jtWMKlpDcEQZDb5uJbGPHKSKULMf+FdfY1ADk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y8XG0X37; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdKsQS13+If1GjddvHhI1yBsl/bfqBjUSA2eGfEkm24HXPleXV79suoE05vAJheyyMdCEDXdE86NtAnTvMM11wEOH9O8t2uAkpTtDU0iXrBAwdRrSp9JBDZnFGfCB6Hv5V8CavbwjS5F21eXiu8pIcG6zKVLD9Pp4FfPOfXYkfxtnyEsaoP/CVMojiZ1AetSz4Jx4z9AGjBJPDzKLgRPGQ5bS2LMOwOhWteICYNknHOoYFyq+fk6jPfeyteN95O7mKcXINcKqzaaE7Gr3VdXtjlj6eBrN0t5xswqEQnNCkdVhD4RVoTUiuUPsVzLcrgRg1Cj1XYfp5ZDt+tWXMGHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46EU+tFy3Ts0yNqktVfrtEJe7o4+EAH4g4YMmHB1Lbk=;
 b=BO55UKkKFPj8PxdwRkS7Vgrkj3c3DOq5zSNrFpqz3i7jnOd+BCsO1e8AA4FOCXM5Mcxx7eWi2nejmer9dM9G98HwZpyha47C55rWUrJqD1eRi0KrbDlg2CHz5a/2VXFMN6Ix3vqjZjG68wfs22i3KVDPE1v95leMRj1SEACP1EUJesSbxF13TjZbaqaFLbek0lfWdsKs3Xk5O82WwJlPGNuXE872MYVt/DRYylFdN/gnkFB92JQUucc5H+qypmW/mOGuUS/Q6Me6uMbh8NuBJI4qd4rmNjJ1lXbn5C0rz0+BRy1qy/Oc4eapq7o+Rwc/eec/5t6O5uCYSRJ2pWTtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46EU+tFy3Ts0yNqktVfrtEJe7o4+EAH4g4YMmHB1Lbk=;
 b=Y8XG0X37IWEyy4LBrnAvNfqYBJfM+mO3Osp5JUWYpqxI/kJFD1FPdbGZdWcCMfEowLsJcyyG/U+VP1sCfMnMugTJB+WoHNhjuuehV76zIoD0YdCTEQN4ke5e6cdKWwECqimtw7wutxnLvzEbOg2RtfHmeoh/tOdkK31EVPePlMM=
Received: from BL1PR13CA0333.namprd13.prod.outlook.com (2603:10b6:208:2c6::8)
 by BN0PR10MB5160.namprd10.prod.outlook.com (2603:10b6:408:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 07:42:17 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1d) by BL1PR13CA0333.outlook.office365.com
 (2603:10b6:208:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Wed,
 11 Feb 2026 07:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 07:42:16 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 01:42:14 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 01:42:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 01:42:14 -0600
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61B7gAMT820689;
	Wed, 11 Feb 2026 01:42:10 -0600
Message-ID: <755e4576-584f-4753-9ec4-cadac42b2e91@ti.com>
Date: Wed, 11 Feb 2026 13:12:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/19] dmaengine: ti: k3-udma: switch to synchronous
 descriptor freeing
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-20-s-adivi@ti.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <20260130110159.359501-20-s-adivi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8d0740-993b-4907-c090-08de694113f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0daSGtXVFU1SEJMd1E2SUpnTERGZEVpbkY1VDJ2ZDBoWGc1UnJkeHpWZlZP?=
 =?utf-8?B?TVNzcERGeHhPeDZ0emFMc09LZ2wxcC9mdzkxSDdHZkhhOVYvbjBTRU0zUGIv?=
 =?utf-8?B?N2Nvbm9VWUd3cEtjekJHRGJLUllRbzlVTEFwUXdCcG80OVdJZHc3ay94MHVW?=
 =?utf-8?B?VmROQk5nLzhPZnhXczRFWjRpWVR5RTQ0TVQ1S1IydHRaYmdVc0hPaEgvdXg2?=
 =?utf-8?B?KzZSd1hieERCNktIdWJxWU5JWWxaNkFYRXgrUXdZUldhZVFwYjg0M2t6clYx?=
 =?utf-8?B?R2dlL3hHNDZVeWQ1MHlrSGYrckNkZTlsQlpTWTZFOHJSem1EZFpoRHd2a3Rl?=
 =?utf-8?B?QzU3YlNMbmtONEQ3M1prYnVYY1JlRnRYaCtuWmtOVmpERDJIOCthSUEya3Fr?=
 =?utf-8?B?ZkZ4WmRjd05EMHY1eWxNcGxjekFjREFUSE5uSEpRcDdZclFDNkE1QU9qYnBH?=
 =?utf-8?B?YW96ZlBCSnd0NVNDbWx0c01QODROcTJxRzIzTGptSEt4aTg1UTFaUzdjUFl6?=
 =?utf-8?B?VnBFbzVnZWtDOW1QbDRSaGYvWHdrbTEwdjVqQmZVZ3Z3cjV2c1RXYS9wQWdY?=
 =?utf-8?B?Q1l6SlkxeC8wYkt1UjVLeUp5WStqbDhDcVZPbExicUMzYkpCc2FnUTU2WEh5?=
 =?utf-8?B?aDhwdU1PVndFM3UzalpTR0ROUUJ1VzBTMUswY0h5b3hWQzVHUGROUHZBY3h2?=
 =?utf-8?B?VFJRM2tYVmxhV2pGbEErbWVDa1VzemtCVUtwbmk3R2RKbiswdzU2OExMMnZ0?=
 =?utf-8?B?bUNHdEc2VE9yTUUyeUI2UTJMNmhoQWVKWi9LT29yMFdnNjNpUFF0cWJSaEFo?=
 =?utf-8?B?M01xa2tSQUJtZGVUMkRRSmlyUXExMEJSV2NkZUJNeGNGSjFoY0Q0M1Jxbkpz?=
 =?utf-8?B?N0s5dWloa3ZLeHcxT1pxSmdUVjFPczJzMjI1L3FlRlhUQ3dDNDRDaXRYa0hK?=
 =?utf-8?B?YTkyWnpYVWtXYWFXR0YrSExvYnlJU1FnVHNKUFpmUnkzS1QxbWZzWXRoSjc5?=
 =?utf-8?B?K0gyeHp4RVBtdTNIeFh5WWtBYWp3Z2Z5dmFMUjVMVk40ZGhhV3N3Z0JmZ1Bz?=
 =?utf-8?B?OFFJdisrbFU3VHdkaXJaNUpEUTJabkw5a096dk44Zm5Wb1YzUjd3VTlzUGNy?=
 =?utf-8?B?MTd2OWFtMktHbkMrVUsxZWZvSVV5eFNDVDE1NUZEZFA1TUw1eXg0S2lndklS?=
 =?utf-8?B?cDJ2VTdkNENjWVdlOUFJMmJwOUs3L2JQbXhOSjZ1eHZXWWJQWFZsUFRPdFli?=
 =?utf-8?B?L3ZUazRBbUhpeU9CZmZBbnZCZk5MakExdjVEMGJEUlcrK09jNzBGa21wQy9y?=
 =?utf-8?B?dTZxVnRWOVdjWUV6WkFKMW9OcjhaUmsrNkNaeHE4OE8rUXhGYXU4My9VVVQ0?=
 =?utf-8?B?Z2tJNk1kWWhzcEpLMUF6dXMweVRVd041dVc0YkNFcjl2aGxoaS9NWWJyY01Q?=
 =?utf-8?B?N01LdHNWMXJDM3I1SlFtYXJsNUdEZGlwbEs1SzU1SFJiYTdEQzZVQ3plNnNw?=
 =?utf-8?B?amF3MnU1UXpQdVV4TUs0Rlk1OE9hWm9tZk5kZGo0bWIrSkk5TlB1Si9yNmFq?=
 =?utf-8?B?Z1I1azU0MlVPMUpuNzgzTk9WeklwKzg3Q1JrQzArU0IzY2NjWVFGL2pVUkw0?=
 =?utf-8?B?Sml2dWxWOXFac01NWGQvaGZabitWY3EwcUpOODBQc2lyeXZoTlQxaWxFR0Uv?=
 =?utf-8?B?UmJld2xQdG9YdThZSDduVXJNbFFmd3B6THhmZTVucTQ4UFpLdmxCVFRYajhI?=
 =?utf-8?B?MC8vbXJTSVFXTFUwMXVPU1IxS2NNamU4SlRoVHZoMEhqRVFhWWJIYi9KWGJw?=
 =?utf-8?B?TUxBemtjdGI1aHBkZC82UmF0Q2tZbHFsNVVUeU5na1JrejA4UENSalJCSXJ1?=
 =?utf-8?B?cEZvZ1lwTnhySWhKTkNkcHE2dTl2eWNtSkI3bnQyVU94bStvRm1NNmZ1amUw?=
 =?utf-8?B?S2pWbE5HR3ZRd3NFK1UxQUpEODBlTWZMRnMxa2Fjd1ZrQzRMeG9oU0hEN25J?=
 =?utf-8?B?bUJXU2tmdkk3S09wSGFiOWxBcmIrVTZ5empGTzJjbWlZeXZUbk5DR1ZrMHFz?=
 =?utf-8?B?eTlZUWMycXY2Z1E2NFFXTUlpNEhCQnNFL3dUV1hyVTh1U3hmRGtieWdlWkVO?=
 =?utf-8?B?M0xDNVNDb2Uwc245NHRqMlpzd012UnRzL1pjcnQzVkJWamRDNmhiRHNVWjhW?=
 =?utf-8?B?dlVCWXkyRWE3cGNCR2ZMcllFRFRPZ25BL2t3UE5ia1ZSREd2ZXBheFY5K1A5?=
 =?utf-8?Q?hJj9Jxm+kXnWedUKdLOrQPdYGvENVQaDWlVbFAGVfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ow+AY4bPV3EsUZg4KMTYpcI4Y76qfIckjADukjkKNjw32wzsA6QWm2DmBTHK6CUi2VdYwKfnk4fADFmuge92uDv+Z6wDtawWyT+5q4LkFlnJj9P2meoS2JPqJ9vRK8BYh6zWRFJxr1hoS2fsrmmAT2AaziUDg60v5WyBAyYQew/8tuJ2R0Ks4BS9yd9F/PAwcj5BbMUE8Nbf5ib8CDbWgKgyCXnO/EUmfPbTbpvgeon189Dvzfa2Ae6nlZY9xdY9J2zhDoq/vYNSp9MPp1LCjc0nK5Yyi9Gw2Iesu6FLYE7KEPIbKTsDCXrPBXYu4/kCLvWzYjGHuWf93NVrxQHNUDhucyvcb5+wSTwEq9yZhqQ6XyyPRNBGJvMJC6OUkTTydFVzWVlL3/bjcFK/oVteDvc81sBOxXzgwOS8WYPBFpRmTs0XenRGjBz1k+i1Fmyr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 07:42:16.0614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8d0740-993b-4907-c090-08de694113f5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8882-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0FE38121EC3
X-Rspamd-Action: no action


On 30/01/26 16:31, Sai Sree Kartheek Adivi wrote:
> The driver currently uses a worker thread to free processed
> descriptors. Under high load (e.g., CRYPTO_MANAGER_EXTRA_TESTS), the
> descriptor allocation rate can significantly outpace the worker
> thread's execution rate.
>
> This leads to false resource exhaustion where dma_alloc_coherent()
> fails even though many descriptors are waiting in the purge queue to
> be freed.
>
> Remove the lazy freeing mechanism (desc_to_purge list and worker) and
> instead free the descriptors immediately in the completion callback.
>
> This eliminates the latency gap between hardware completion and
> software reclaim, preventing the pool exhaustion during stress tests.

Please discard this patch.

Further testing revealed that dma_free_coherent triggers a

WARN_ON(irqs_disabled()) in this path due to atomic context.


I'll send a v5 with valid fix. Apologies for the noise.

>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>   drivers/dma/ti/k3-udma-common.c | 40 +++------------------------------
>   drivers/dma/ti/k3-udma-v2.c     |  2 --
>   drivers/dma/ti/k3-udma.c        |  2 --
>   drivers/dma/ti/k3-udma.h        |  3 ---
>   4 files changed, 3 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
> index 05b2b6b962a06..f9da00298b60f 100644
> --- a/drivers/dma/ti/k3-udma-common.c
> +++ b/drivers/dma/ti/k3-udma-common.c
> @@ -95,32 +95,6 @@ void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d)
>   	}
>   }
>   
> -void udma_purge_desc_work(struct work_struct *work)
> -{
> -	struct udma_dev *ud = container_of(work, typeof(*ud), purge_work);
> -	struct virt_dma_desc *vd, *_vd;
> -	unsigned long flags;
> -	LIST_HEAD(head);
> -
> -	spin_lock_irqsave(&ud->lock, flags);
> -	list_splice_tail_init(&ud->desc_to_purge, &head);
> -	spin_unlock_irqrestore(&ud->lock, flags);
> -
> -	list_for_each_entry_safe(vd, _vd, &head, node) {
> -		struct udma_chan *uc = to_udma_chan(vd->tx.chan);
> -		struct udma_desc *d = to_udma_desc(&vd->tx);
> -
> -		udma_free_hwdesc(uc, d);
> -		list_del(&vd->node);
> -		kfree(d);
> -	}
> -
> -	/* If more to purge, schedule the work again */
> -	if (!list_empty(&ud->desc_to_purge))
> -		schedule_work(&ud->purge_work);
> -}
> -EXPORT_SYMBOL_GPL(udma_purge_desc_work);
> -
>   void udma_desc_free(struct virt_dma_desc *vd)
>   {
>   	struct udma_dev *ud = to_udma_dev(vd->tx.chan->device);
> @@ -131,17 +105,9 @@ void udma_desc_free(struct virt_dma_desc *vd)
>   	if (uc->terminated_desc == d)
>   		uc->terminated_desc = NULL;
>   
> -	if (uc->use_dma_pool) {
> -		udma_free_hwdesc(uc, d);
> -		kfree(d);
> -		return;
> -	}
> -
> -	spin_lock_irqsave(&ud->lock, flags);
> -	list_add_tail(&vd->node, &ud->desc_to_purge);
> -	spin_unlock_irqrestore(&ud->lock, flags);
> -
> -	schedule_work(&ud->purge_work);
> +	udma_free_hwdesc(uc, d);
> +	kfree(d);
> +	return;
>   }
>   EXPORT_SYMBOL_GPL(udma_desc_free);
>   
> diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
> index 6761a079025ba..d33382cc0356a 100644
> --- a/drivers/dma/ti/k3-udma-v2.c
> +++ b/drivers/dma/ti/k3-udma-v2.c
> @@ -1320,14 +1320,12 @@ static int udma_v2_probe(struct platform_device *pdev)
>   	ud->psil_base = ud->match_data->psil_base;
>   
>   	INIT_LIST_HEAD(&ud->ddev.channels);
> -	INIT_LIST_HEAD(&ud->desc_to_purge);
>   
>   	ch_count = setup_resources(ud);
>   	if (ch_count <= 0)
>   		return ch_count;
>   
>   	spin_lock_init(&ud->lock);
> -	INIT_WORK(&ud->purge_work, udma_purge_desc_work);
>   
>   	ud->desc_align = 64;
>   	if (ud->desc_align < dma_get_cache_alignment())
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index a8d01d955651a..34d458b4a0dbc 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2704,14 +2704,12 @@ static int udma_probe(struct platform_device *pdev)
>   	ud->psil_base = ud->match_data->psil_base;
>   
>   	INIT_LIST_HEAD(&ud->ddev.channels);
> -	INIT_LIST_HEAD(&ud->desc_to_purge);
>   
>   	ch_count = setup_resources(ud);
>   	if (ch_count <= 0)
>   		return ch_count;
>   
>   	spin_lock_init(&ud->lock);
> -	INIT_WORK(&ud->purge_work, udma_purge_desc_work);
>   
>   	ud->desc_align = 64;
>   	if (ud->desc_align < dma_get_cache_alignment())
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 3ae2400e67990..67de9feb9906b 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -353,8 +353,6 @@ struct udma_dev {
>   
>   	struct k3_ringacc *ringacc;
>   
> -	struct work_struct purge_work;
> -	struct list_head desc_to_purge;
>   	spinlock_t lock;
>   
>   	struct udma_rx_flush rx_flush;
> @@ -596,7 +594,6 @@ static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
>   struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
>   					    dma_addr_t paddr);
>   void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d);
> -void udma_purge_desc_work(struct work_struct *work);
>   void udma_desc_free(struct virt_dma_desc *vd);
>   bool udma_desc_is_rx_flush(struct udma_chan *uc, dma_addr_t addr);
>   bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d);

