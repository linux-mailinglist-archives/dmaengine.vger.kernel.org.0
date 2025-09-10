Return-Path: <dmaengine+bounces-6441-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D123EB51B99
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7BA3B9ED8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865EA25394B;
	Wed, 10 Sep 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HhAxLoDd"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5B286439;
	Wed, 10 Sep 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518119; cv=fail; b=i3GrW6FKNIiSApT+PaIEwKZeIERqA+wDMY3WJYd5N6n+39xAwI9OeBh5Zrdr3TwkFejpL2xTSnzEi0B8uaZBbwJT3qEPgS5X8ztJMjdWTYy7wzmXPa87xbHdhs9ZLORfto+oB4DkRpGM7ddbbIjgjP8zbOtZyyw9Bit6TOS8nC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518119; c=relaxed/simple;
	bh=LQpfVDljiU2i+ZSB0i5HKUkDH/tkwTqdhnyBHA7UnHU=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxNW+yszVmG84mBiHD6vXzaeUBmDsRD5MhP3tiXRqfkZJJI4+vV9f1aMyaFC34pMIMiKQR81jbl9tEzogm3nkwFJWg87tBM1XYuzyQrwx+urrLVAmeKxza1oRMhll88QkPwMbvexgPhrdQ3h4A8aZOgS+MNC7msa/eWiZGNMjyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HhAxLoDd; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBCO6N6xs99w6N6jaH9HILFmyOQFbOz08m93c4y0vUa2Ct+yjo8n81kwWSE7nZ08lMZ8KSyQOQnnCRKbrqT5MZ5AOzBSkfitCI8/S1F6Vv/tgm/o0vrlrcLgULojtBoZ667dFIPK3BXn5XpCRVNnL7NyQiJjCwEJPKCoU4+XaBbVA2WTE9svnBu1Ydy6Ql0nUs+bH39c0q8uOEc5wYJtC/cOeE5hhi8ctLIWL8ndjauM296zmBwlDkvrNUVRXBWwEUregwr6ED+fzYGytyCnz51s2ygN12pGLTvJIysW4bPiwGyPFl6WiktiHqPtGUGhzseeky3Ues6WZ/CDrJyj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXmoMLThRzyPa8vvWey5ilbWgJ3JZXCCn6jiIovhACo=;
 b=eP6rjotzwSNthxbLD3MEyTRdIAPdfzz2S+3kG66h2weoIlYnoDCjpLczz+8q2/wblQvZcwKzElhvVVu6VgdGOvzRciV6oDCR/LeyNXsYQZEiKk3O/92SvxrDgFBPBaTRhQknoz2TYHXTYC5nP/iMoYF9sbG9+CgMAlDIeWBb5qn/1curcD0b61WqMFjvkBuFYExllwonBHXInqpm3P6BBq1r8j3uDgmmiS4Y86VobHCZ+oeYUtO+Zqb2cRNHcJhPekCDxbLollFB7Lbm7p2BmtgLNlH79weKhRSjwy6O0SoBMiu0C2JiR2zWX1B1P9NhzM7u5nmrfsx0e9pLj95ssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXmoMLThRzyPa8vvWey5ilbWgJ3JZXCCn6jiIovhACo=;
 b=HhAxLoDdOBUgEKYmqlT1hwaZGwzOkNfdrA9EAU5Ch5Xc0VG+KJDIVqg/wKqf4V7gDY9qcpqhqUUZ6xG6KI3FoDjHXUPLR3oaA45FRElt0WpLP6juLrTlI2fHvJ9yzR9GtilT4Y069h8fSMVQ8ZdT21l4i8rdrcxlnF8xSmGJyow=
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:28:34 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::a9) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 15:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 15:28:34 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 08:28:33 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 10/13] dmaengine: sdxi: Add PCI driver support
In-Reply-To: <20250905200520.GA1321712@bhelgaas>
References: <20250905200520.GA1321712@bhelgaas>
Date: Wed, 10 Sep 2025 10:28:31 -0500
Message-ID: <87ldmm499c.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: e2aa8fef-eea9-4fdb-e394-08ddf07eb4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3Td3fksz5L5x66e5Rhpn3o7zHPXLawiwPFKQbIbgu2cn9ozM1fDupBQ53YP?=
 =?us-ascii?Q?5t8IVh1TokhhT04TtGyZOyZQXqWl2MLFM9uvrfWX3d2wqunURZTsZgIynDzv?=
 =?us-ascii?Q?ZfphFYqiC7P9woew2aXNTdTGrDc9GBp24vS8JhEQ3b1gR6VT89ZpWbiAXyzy?=
 =?us-ascii?Q?edaH9cTtPW2bukV3GrEAdLBGx0cXrijKNLCTW8FgjTgD2ADS/4E8Imrj/n8J?=
 =?us-ascii?Q?XgBYDUu1OwPVsFxNQh5Jvp5lDBmWw8+sled2qTjC95eWm11OehYW+s4XieFA?=
 =?us-ascii?Q?9qICgIqMh5FwUJSBgXtiLeYRSZv/ns8kkvfLuM3fCDSeEytg9iCPZso6vhbo?=
 =?us-ascii?Q?ur6cGiIv7X4PKHoS8OTh/bbbCvXEJDPu7TZHbovgpDDMJjR5ayKvygsVn+n0?=
 =?us-ascii?Q?JjI8JJoX0XbuKCYcH7YsLAcBIYDfVMOEhcELOvPhaHvJxtcPPi4DwafRaclh?=
 =?us-ascii?Q?KO/tSBluZEEZIjNSsjaRb7WWpd9clvi+uc82GihKzAXA1Xpz9zoqotr2jpIs?=
 =?us-ascii?Q?3ihbDa3ngwgz+TQcOfxEsyRxjexy1FUqPiYQ2bPhMgnJ2GCQTzJSD4FFVCZW?=
 =?us-ascii?Q?Yqbe7Q7IIdk16tGil3qMUbCOwcONDqmAsCyA7xNaKmAmWClqKSojbEe9bqzi?=
 =?us-ascii?Q?fzti35iZtMuvSDPZ4iqmbIwn+cxHpMrIl+RkJuMJVeQsR5K6qsO69E0khwuS?=
 =?us-ascii?Q?A3Gwb77dGg8dNSs2qrBpZAHo56Zg+VAZcwm11rVKpmpcrgGq4Mj6K2/6DCsA?=
 =?us-ascii?Q?eU7ZCOdLeeJZAeRjeNFiQEhadXvPOG4yfTfH15kEcx743VH6VQ5hwXNJQdf0?=
 =?us-ascii?Q?GRMgU0ZYn7CnyBWN3w0jTHYGTU62yG3wJ7OqrU7EVE2E+zi5B5lOoRXEp9ft?=
 =?us-ascii?Q?1f1IT9cgLy1g6a4RUUtzpAc0NEOPe469SvsIUDfCjyPzmongfXGxrxBVuQMF?=
 =?us-ascii?Q?Oi6DiEvtmEDvETGfvydGTkUMa2rcXOtcjx01sPiJw/TSBQJ/RseOLAHrxwld?=
 =?us-ascii?Q?Jso1zX0u4uj4P2y4LH1WUw3BfygM7ph6Lsufsjcv/7jkaa+lUMBlsksWw7lk?=
 =?us-ascii?Q?2z39APWscb6c9QZWYlE/8z7BTfx5nvajBVwLRitGvEm4t5U92Or7J9W656xQ?=
 =?us-ascii?Q?eDxnUxetGTIoCMT5j+z2MRKvy+hdIwC+82GJvEv1sVeuizhLrGHqcKX66Njd?=
 =?us-ascii?Q?T3HyGFR8+qNc+sktJMFRk3x5kC8fycySsCNDRkPiow5uyLiFDHHNH0O+YkmC?=
 =?us-ascii?Q?ey/DDZlJUWl0F5BqVqleKezgZJG2AQtav73WAi2C7HZRuju84J4s5HUH9ci4?=
 =?us-ascii?Q?s1QIz3E5ZDfC2RYPuWDUZG/C0+ZHixNXNz/LhQMOjrcMnIZK2kGgTdyKW99w?=
 =?us-ascii?Q?c4RNG4/tG99kONzMtPpjX8VzvaCLlSp4kaNHLtZWiiC35R09BEXQlfnjjNN8?=
 =?us-ascii?Q?fbDtvhSOIQG/jj3uOgpGYTSUiyHOrelB3dNXfb8Z+3t/YfjYyc3B/wz4TrbQ?=
 =?us-ascii?Q?0pyn01SWMVxBTz3uq985QhKFXo91irPtuDMs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:28:34.3248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aa8fef-eea9-4fdb-e394-08ddf07eb4b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Fri, Sep 05, 2025 at 01:48:33PM -0500, Nathan Lynch via B4 Relay wrote:
>> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
>> +{
>> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>> +	struct device *dev = &pdev->dev;
>> +	int dma_bits = 64;
>> +	int ret;
>> +
>> +	ret = pcim_enable_device(pdev);
>> +	if (ret) {
>> +		sdxi_err(sdxi, "pcim_enbale_device failed\n");
>
> s/pcim_enbale_device/pcim_enable_device/

Will fix.

>
>> +		return ret;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_bits));
>
> I don't see the point of "dma_bits" over using 64 here.

Agreed.

