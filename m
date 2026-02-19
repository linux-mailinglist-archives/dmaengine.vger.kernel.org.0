Return-Path: <dmaengine+bounces-8973-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIzDHhT/lmmItQIAu9opvQ
	(envelope-from <dmaengine+bounces-8973-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:16:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB415E88E
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D888D302416D
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE228DC4;
	Thu, 19 Feb 2026 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QXu2kU/N"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D803EBF27;
	Thu, 19 Feb 2026 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503357; cv=fail; b=JH3yFoQKQhqCTjBI7Y+z5JhXxT7H8cOFnnGQzxjvcyJ70Sd87hjX3Aq5miaCgtoYXl0+zbqsjypAM4xrOsTGtk7F2Ieio1YoIINzdxaiyRLhu7qrpimKfh0dRoUbt0eW313IElHrhxC93rjtrEYx8CMbOrs4jMMUmaAkqwQdRVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503357; c=relaxed/simple;
	bh=x8PyGQvk/sn6USXrcsfHbRC2CJGI/bVCmoDb/tc/zwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kgamJETD3gOg+FJmDXl20O2OmBqxbetIQAhRqP3fP7VLWoRm0yNS2xMqhHKY4Fzg1LvgZMgKzSE2MkWP8PWryp3W4Hf1JDTu8kFGoVoGN4UGdL100WxhqbGnT5GfZ55E+5Mo4fx6WRv/aylmbELyIA7msjZr0HJRhC3Vo2kO7Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QXu2kU/N; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7OYQ2DS7ZSGNey/78euqZeBVDkiqJMtVrlMxhbdFjojZetbFJW7XQtP1yT7MzTpr3JmULQmXl4TMlTDQ4KkB5Zd5AB3mwMTUn54MsvjoDjNajRO6p4Z+XoSH9IGRb9UdKyaBLE/wBjak/WmmIkP16LFAtbIyCb0PKq51GaAP11gKkriLSh0QPKb3vyBGfAdXwMJ273wM5XVELgZZcDJHGqrVoGUvMEGuguS/+EEnIwBW14+cZzQojiaP9mZbF74pEG1n7eAv3wcmsZ4xOUofQo5JhvEXr+UbKFo04PXRp9RBjFxrspSa3ahSE/1+z1S4ivmoymL6rzOlfSgAspreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQD5C7JM9IOiZsAx3Oghg/cSf870BL7KGoF+HC+FA40=;
 b=U7J7D6AIfthPuxWQgwtPCuT0HvoZ3lk3YIqodxfx6Pd9eyFY+8vrziyFxINsrJfJ/UpyqrDJ+011tgxC162byMNmYoszsN5c0BtYTQ526fjcE1HCLyLV2ioxTewTv8oIf5DxV+9fs2ae5Qwe4bFsjGnHwNWUl1lueELnCKoWhCYLVIEv3UBgx6zOmM3H3+aaWellFYfwJtsqfUmhFIU1IM5sHBiFouaIq4n7itpoqnz7B6C7TuS2aZhR36XuCHg/2ywW+bFJ/c1NMnt/cZ/2LvcU8By86GCiIIFP71BznlETTXlGQJG+c6czfHbBQVaIpwmjmqLmktSAMo+1Wh1ehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQD5C7JM9IOiZsAx3Oghg/cSf870BL7KGoF+HC+FA40=;
 b=QXu2kU/NvcTICbfp+dGZ8+gtZjJpj174+vY/sbx11LZotOzw3kpX/kMSAx+x+S6uI4JIEFfrLL5hBBiEee7u3jYbWjLrQ8bcoMK4OIrJlul6ZotwSfvKY1M2V4kK65viVXgpE+AM4CfRt09LfsRL/dU11Ati7iyZawurgwXCkGc=
Received: from SA0PR11CA0132.namprd11.prod.outlook.com (2603:10b6:806:131::17)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 12:15:52 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::ab) by SA0PR11CA0132.outlook.office365.com
 (2603:10b6:806:131::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 12:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 12:15:52 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 06:15:51 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 06:15:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 06:15:51 -0600
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JCFkUb2557296;
	Thu, 19 Feb 2026 06:15:47 -0600
Message-ID: <bab85365-063a-4d46-a1bf-48a25228d109@ti.com>
Date: Thu, 19 Feb 2026 17:45:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/18] dt-bindings: dma: ti: Add K3 BCDMA V2
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <r-sharma3@ti.com>, <gehariprasath@ti.com>
References: <20260218095243.2832115-1-s-adivi@ti.com>
 <20260218095243.2832115-13-s-adivi@ti.com>
 <20260219-hopeful-intrepid-cuckoo-32967d@quoll>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <20260219-hopeful-intrepid-cuckoo-32967d@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 299c9bc3-c5eb-4842-d6dd-08de6fb09ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0RuQWJJV1dIVU42SjNsVTEwTjRKTHFrbGgxWllmdUZxZ0x0R1NZclB5aGdE?=
 =?utf-8?B?UWxHSTRhMFhFZVRnTDNNbjAvbmRKZS9xTkRSY3d3bHhQSkVqMjFWa0w1aVpV?=
 =?utf-8?B?YUlmUnB2ejFNT1VFaUlDUTcvRndDa2JRNmo4a1hFZlZKVVk0Nk00OFRHa1NV?=
 =?utf-8?B?SXJ0R2RaRVBwOHN0UEUyK2JaeXdEM0szcFRPaXdLenR5UEl0YjVJZXdYWE1K?=
 =?utf-8?B?cEE3dERzeEZoN3lmNnBSWXVFNFhMSG5ITElaS05sbTVERDczWkNuV1p4Ym92?=
 =?utf-8?B?bmgrYlhaZTJ1b2Z3NDFYZUpndjl1UWU4K0ZaQWh5WXZCaWhDSUFzME52eUlm?=
 =?utf-8?B?T1hvY3NlL3Y1TVRLRlZkcmk4VzdqN1NpdjNNUUxjOVJtdjF6Y1VYNkN4RzVh?=
 =?utf-8?B?RzNydFI5cVg1Z04wUVNLY0swa0RYbTI2V2U1UUt2QVg3TVBqYk01d3VOMUFt?=
 =?utf-8?B?aVdBZExJZlp6bUdGbUVnb1RBd2xDUjFheCttRXFuUDE4ZHdyT0RJZGNWbERN?=
 =?utf-8?B?TjRIYUU3T1hIWWsrNHgrd2ZxYlZ1MDJ2Rk9TMitkVHN2aFJFQ0RZSVpiNHB0?=
 =?utf-8?B?dVhrNjJFN1NuYVNRbnova1RaSWdhenc1ellwOUR2NDFscnRpcjhrd1o4c2lB?=
 =?utf-8?B?c1Q0b0tOQ3dWejFOMko0azQyamxwZGxXUGk5S3B4VlEzb2tZSHM2SU85Wnp3?=
 =?utf-8?B?UlJwT1h3ZE5UZjdDZjVzbWxUVmJSZVcySG5TckFsUDdVNk1sVEhQdlp2VjJx?=
 =?utf-8?B?cUI1aThmdkIrQ2U0T1c4Z2g1bGtMRGw4eVpGc0s1TzE2VktYWnRHOGt4MEFx?=
 =?utf-8?B?N3B4ZGdTSEVyQnhQT3ljSkRLV01kOTNNTTZvZ0hHbGJxYkkwQUNVdlVUUGhV?=
 =?utf-8?B?UXZTMTZ6bXdDSUw3WjduYWFGVmxwclZhU0sxVzRkY2JKMFFrU0ZEeUxRQmxR?=
 =?utf-8?B?VE8xLzhsWlRjbGJvdXgxaitqZzJjZDY0a0FyV3E1NzdKRkt1NVczNTRLNkpr?=
 =?utf-8?B?Y1ZYM291aXdVMmJwYTlqeXFjd1lwUnpJbWZyNFVEUytTRUF0TW8rSnB3bVZD?=
 =?utf-8?B?U2NVcWhjRS9GbXFpNEUxODlxd1hMdDBsOTdhVWx5ZGpaYVJRc2FISCs1TkZz?=
 =?utf-8?B?ekR3Z0VSN1VQSkRURmxwN1lIbmRucGJXRk5KYVNWZ2h2SzZmWE0zZDAxT0tx?=
 =?utf-8?B?UTNJaTRXemJUNFVMdjM2Ymh4ZlNWZkxCQmhMbFNVQkVONmU0a1RaaEdUYW84?=
 =?utf-8?B?K012Y0kzcERWdEV1VUJNUGpHZlFMVXpidENucStFVnhUSWd0TUhmWWZPT1VJ?=
 =?utf-8?B?OFlyMHd6ZnNBclZVTW1jVjgyanFYZWgyTFZsVHROOUlWbHIveHZFKy9PSDc2?=
 =?utf-8?B?VDlNUGtGeUJpRHJoQzRJQlhBUGZYb0dteFZhU0NQeXdtOUxlMzJVaGt2U25r?=
 =?utf-8?B?UUxGa0NxcnN2cnAwKzJJOFMyNDdVMnZQNkpZdEVzZEtnMWYvV3VQT3AxUnhC?=
 =?utf-8?B?VE8vSHlacWhhc0ZrRjZ1WVMxeFpEUTdQQndhb3ZHRW9hSHlEY1M1bTg4WkJE?=
 =?utf-8?B?TTgxNzR6Mk1VZDNoZ3pjUXFiVktrdjJxNU1Vc2VPL3c5ZnVaMW1IL2lSNi8x?=
 =?utf-8?B?VXhMdW5EOGsxSnZpUVNjc2VqWTB5US84NDVhV0VtV2Y4UERNcUtlcWZlMVU4?=
 =?utf-8?B?U0IzRXpKSHNRcElwWGlISXh1Nll5NHJTMmtMVVdtdkJvTlBmOWJoUTRCWEtV?=
 =?utf-8?B?NXhDbkxwcWRYNmlFUVpqM1Z3ZDkxTGVqRzYwUjlBSkV2ZG0zVTlDdTdYSGZS?=
 =?utf-8?B?WEQ0aWIrRVpjbldQUng0M00vRUZLeEJNUW9yL25pT01Cb3dkQjh0RXYrR0lz?=
 =?utf-8?B?ejdKMVRXcDluWVdIcWtOK25XS2ZTWWZmeTJ6WWhTQ1NOOTQvM0V1N0dCMUhr?=
 =?utf-8?B?M1JKbnM5Tk9sK2FBR1BuUEJFaUY4VnpvTVZSVE9va2dBTFZCYndvVkdTYkJI?=
 =?utf-8?B?anpPaUxCZnFXaGdmWE5nWUJ0Q08rNVRoS2p6SjFTQ1d6bnhKSk1EZ1JDeTc4?=
 =?utf-8?B?RG92Y3hkcXhxMFBTTDBhNEk4Y0txUEFyTjJtYXJ3ekxhU2Z0Z1BocGp3Zm1l?=
 =?utf-8?B?cGJKMnRVcXB0T3RoWk44V1U4VWsvY2Fhd2xQcDF1UmNxdlVONTFWTk54SUZU?=
 =?utf-8?B?Zld1QWFYNXIxeURiY2psd2EyUnprVU5Jb0dDRHB2cWtsUDVpR2Y3UlFSTlVl?=
 =?utf-8?B?ME4vZDZBTWtVNWZvdTlyd3ZkM0hBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EXiqe07+TRyfZjs/F/jv6dlI3EEKXcHXTkK5BHEzcVTCztpYbqL3G4veojZWqwwhIZzQRf/AkjKgkrotWb4Sm/ZfBuon6PmkxQz9ES3Y6Lc3n4+ZoBdGR4R4Vp0QADcxO0PnY+JhEQdI14ThLnC7XMcgL5iFX90WicuC73D0V4xanDOvTaSL6QjKiCfm5ZKHYd7KgkznbRcGw4I/vyM/VBuT8Fj6gEvgbbkwRdKnq7/Dz2SPpKNPnC2VW2xS+ZmC/tES+wkud4d2zGuomsV/OnOFUgSC2V4vJtdkjF5lEB/WOqD1lzoyH9K/trlGzaFy0geZwPkOsdNWxGwisnn904C6fGDU5gKVQuM/t855V5HA3PESZSinKIIJa+t6EPQlMlKg/8K7eOqHjNpnHz6hWLbbLJtqYteyhqkno0YZAOWBJ3EYvhvO/6wsRdwQR3C5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 12:15:52.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299c9bc3-c5eb-4842-d6dd-08de6fb09ff6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8973-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email,devicetree.org:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 24FB415E88E
X-Rspamd-Action: no action


On 19/02/26 13:13, Krzysztof Kozlowski wrote:

Hi Krzysztof,

Thanks for the review.
> On Wed, Feb 18, 2026 at 03:22:37PM +0530, Sai Sree Kartheek Adivi wrote:
>> New binding document for
> Fix wrapping - it's wrapped too early.
Ack. will fix it in v6.
>
>> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
>>
>> BCDMA V2 is introduced as part of AM62L.
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 120 ++++++++++++++++++
>>   1 file changed, 120 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>> new file mode 100644
>> index 0000000000000..6fa08f22df375
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>> @@ -0,0 +1,120 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024-25 Texas Instruments Incorporated
>> +# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-bcdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments K3 DMSS BCDMA V2
>> +
>> +maintainers:
>> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +
>> +description:
>> +  The BCDMA V2 is intended to perform similar functions as the TR
>> +  mode channels of K3 UDMA-P.
>> +  BCDMA V2 includes block copy channels and Split channels.
>> +
>> +  Block copy channels mainly used for memory to memory transfers, but with
>> +  optional triggers a block copy channel can service peripherals by accessing
>> +  directly to memory mapped registers or area.
>> +
>> +  Split channels can be used to service PSI-L based peripherals.
>> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
>> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
>> +  legacy peripheral.
>> +
>> +allOf:
>> +  - $ref: /schemas/dma/dma-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,am62l-dmss-bcdma
>> +
>> +  reg:
>> +    items:
>> +      - description: BCDMA Control & Status Registers region
>> +      - description: Block Copy Channel Realtime Registers region
>> +      - description: Channel Realtime Registers region
>> +      - description: Ring Realtime Registers region
>> +
>> +  reg-names:
>> +    items:
>> +      - const: gcfg
>> +      - const: bchanrt
>> +      - const: chanrt
>> +      - const: ringrt
>> +
>> +  "#address-cells":
>> +    const: 0
>> +
>> +  "#interrupt-cells":
>> +    const: 1
> I don't get why this is nexus but not a interrupt-controller.
>
> Can you point me to DTS with complete picture using this?

Please refer 
https://github.com/sskartheekadivi/linux/commit/4a7078a6892bfbc4c620b9668e3421b4c7405ca4

for the dt nodes of AM62L BCDMA and PKTDMA.

Refer to the below tree for full set of driver, dt-binding and dts changes

https://github.com/sskartheekadivi/linux/commits/dma-upstream-v5/

>
>> +
>> +  "#dma-cells":
>> +    const: 4
>> +    description: |
>> +      cell 1: Trigger type for the channel
>> +        0 - disable / no trigger
>> +        1 - internal channel event
>> +        2 - external signal
>> +        3 - timer manager event
>> +
>> +      cell 2: parameter for the trigger:
>> +        if cell 1 is 0 (disable / no trigger):
>> +          Unused, ignored
>> +        if cell 1 is 1 (internal channel event):
>> +          channel number whose TR event should trigger the current channel.
>> +        if cell 1 is 2 or 3 (external signal or timer manager event):
>> +          index of global interfaces that come into the DMA.
>> +
>> +          Please refer to the device documentation for global interface indexes.
>> +
>> +      cell 3: Channel number for the peripheral
>> +
>> +        Please refer to the device documentation for the channel map.
>> +
>> +      cell 4: ASEL value for the channel
>> +
>> +  interrupt-map-mask:
>> +    items:
>> +      - const: 0x7ff
>> +
>> +  interrupt-map:
>> +    description: |
>> +      Maps internal BCDMA channel IDs to the parent GIC IRQ lines.
> Isn't this mapping fixed in given device? IOW, not really part of DTS
> description but deducible from the compatible.
>
> You only need to provide interrupts for your device.

I initially considered handling the mapping in the driver based on the

compatible string, but discussing the hardware architecture internally,

that approach becomes highly problematic for this IP block.


While the mapping is fixed for the AM62L specifically, this same BCDMA V2

IP block is reused across different K3 SoCs, and the internal

channel-to-IRQ wiring changes entirely from SoC to SoC. Furthermore, the

mapping of internal channels to the parent GIC interrupts is discontiguous

(and the hardware IP itself supports mapping multiple DMA channels to a

single shared IRQ line, depending on the SoC integration).


If we rely on the driver to deduce this via the compatible string, we will

have to maintain large, discontiguous mapping tables inside the driver

code for every new SoC that integrates this IP.


Because the IP is essentially routing its internal channel events to a

different set of parent IRQs (which varies per SoC integration), using

interrupt-map allows us to accurately describe the specific SoC's wiring

purely in the DT. This keeps the driver clean and easily reusable for

future K3 SoCs without creeping hardware routing tables into the driver

code.


Let me know if this clarifies the use of the nexus properties here.


Best regards,

Kartheek

>
>
> Best regards,
> Krzysztof
>

