Return-Path: <dmaengine+bounces-6523-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C089DB585E4
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 22:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768393A6569
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 20:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB61427B356;
	Mon, 15 Sep 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FvCYF3L3"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7EE2749D9;
	Mon, 15 Sep 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967455; cv=fail; b=LuzvdHBmwMO2+nDXF+esRT8bNMwUmD2AtMucmZVo1dBuX9x5F5p2ZhcupJDP3PyMNpehAYrHl3xgBmpgN/mzoh2WT9FlaY1BAij34jqUWu7Fo4r0KkN6uk+264h4Zr53H7EzXTgRPcmUpjaKeaINUm6fIDJBZt24DlFlj/v3tp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967455; c=relaxed/simple;
	bh=50OYNTAS+I9JtY+Ptjrrvg4G6CYQAoDGkI/V5TRAp2Q=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pQcorEbDxsXoZJC7UlyYva2AN8XjDVi3Pp/eiJzapErOLx9guKCdYdoaUBK049qy6/R/x53PUDORDksUJIncgCLlCQ7sgnYFoZagsWhEpfG8WoghZ0ZCSkhDUqeRwzn//Tfuefu2AcfT7p/QxawO7BwmDOXvaqhVk/G7onaDXmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FvCYF3L3; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSyF2a2LXTrpG+VLuqtLerpM14Jaf4zEEOQo2jrhUUN1kU3gnKJPRlJ3s8qx0t8jiUOd4IDeEKQ1n7bfc/F/vdfDqBF8rG5RDTeVMdK6zJkvAytK58+WBKsXu4F/qlqPYkBWo2bQZxF6rCQ9ycGmb04Z2VJ0giYFerX1xE/IHwGGHqC1L/gXbUnA2rvuvN+9BS950NVYvmls48L1dl/iMpwwXqQFHzsIejuENiNMIjA0CUTt2lF/NKFPRdpm6lPBDuBUpJpRSpjSC9ORCDyhNqHAX4ffeVS5AJc+9YyZNzsUGDYq/Ae9DkN9Ew8cWVKi2FHbYFI6mMlR/KXj5kU88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKA3zMkye8A/4vBriXBNewBtM3Dew/c+H1N5CLDrTn4=;
 b=qXMbIXFI1Aie8wPZPp5O/qrFFgHQ3y9t9QWFlewKXaYca8xuzP7OCaycMJDeIFQqi1/nofW/05CixpxlnU9K7fjgCFXy7EgaTLcvxHrEbdO/aWVkccyDDISRLv7XKSSqJBHdoKJ/C0/27ScQdpJNs8nlSW4vIuOxpKcPUJGromGuXpDD5btB+KrHwnYpWsaPuvKAZoT1+IWEN1NvuJ8CoZTLLmrO3O2Bd4BYn186uw0ibz3+eGsZXpSxpi4tq3ec+QBitYRtSoOotyMACFhaRfQotL0zHI5sKrM0zsHykHvb+6A1Y/mwAXVrpeLLONfpoJfzwCnOp6e6AVL3pPPU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKA3zMkye8A/4vBriXBNewBtM3Dew/c+H1N5CLDrTn4=;
 b=FvCYF3L3ZbNfgPwWj2gEq8FWwvTi/PuATtxpqRcDKon8JMGLaaOd/Q2RFry4PkFTC/VN+3O7Z4GQnNs8fVIANR8ifIQDsdO5e7HX6nBMkplp8FlPDDc3yC4RLCG6SXnOCMkUGJstv/wHIl/Y+qeBEQUN7NDPq7EiNwouFdtdxdo=
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 20:17:27 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::10) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 15 Sep 2025 20:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 20:17:27 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 13:17:26 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 01/13] PCI: Add SNIA SDXI accelerator sub-class
In-Reply-To: <20250915172509.GA1751399@bhelgaas>
References: <20250915172509.GA1751399@bhelgaas>
Date: Mon, 15 Sep 2025 15:17:25 -0500
Message-ID: <87ikhja2sq.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: eb65c31d-18a2-4740-7399-08ddf494e3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9kWxbQTFrEBUwcBCiP8uPzGM8RIHTFTu/Mb+BW3zhd8b5CEEavwIiGC8NcM0?=
 =?us-ascii?Q?pwQeuPTOqLJ3SgQCrHQsv+o/dTsWRdmGPtoQSoIqLk7cSq/fTmwDed9yWDa7?=
 =?us-ascii?Q?VkZIIRiRo2t/5Ka7DVLLP6gDpwzFXOuBk7qUz7LRgNJO0tr+WPyNvxy+gMqt?=
 =?us-ascii?Q?WDboaLfaDzfasBowYMWgscv4vckNFeEX1I/PgYMskgBlIBBW5LMTM9Jz75ZM?=
 =?us-ascii?Q?cm1G1KuudGMEg40dF3ZSzOI8TH0jCnbjR6W0lvxmbKK8P3dqaGTLefBDsefp?=
 =?us-ascii?Q?zoTqCg4djmwyF58/Cc8O5PP2QPmuoTh3Hwa8zYbtChoSutPP1ZgW4gqcd0f+?=
 =?us-ascii?Q?lkI0xYPkq5iXLTw3js+V1LPNELTU4t/2cbpwzbmi1+f5sk1XIBcQdX+UR4kL?=
 =?us-ascii?Q?V9ZXPFYJSBEyRXzkPGuvtVxnZ1/PJM7kf47lEBfx9uSivJxbL/iUPtRMmPtB?=
 =?us-ascii?Q?5cQQmvjWNTK2HX9BjndJRK6k0eNpewiwXaQrg3cdLegWePdOGStE637ZoHeW?=
 =?us-ascii?Q?YNmkR+U49QExc1eRFcntPZLqH/Qt6UTY3zSY2/czoX1tvBiPNlP2Q7UPdlDH?=
 =?us-ascii?Q?jRY33qtiAXavdW583Bt13Jjobmgf4pZ7QGAYkhQDbnSQgVkIrse5zkZtZd92?=
 =?us-ascii?Q?SjSUDsfv489UNcUNq5u7PmrSDhnFlscZfX6RRMXBpuOYQirD8CQQW0XZNaTe?=
 =?us-ascii?Q?Fibzi7gsAhVYUTaxXMb587eYTSh2IsYYpznwgdPPJlTlmmV+mjJrsGAcNcIs?=
 =?us-ascii?Q?+WfhizIfKd1uk0R/yrZ+4HmQBZip+z5EYt0ey2CR+Ar2sLPcQvVe6p7D/UAo?=
 =?us-ascii?Q?QePTWZowk7C7gIKO1ixNx6tSgJMJ8tzVd+szcRtXf3e3vihQAfEhFhA6r+St?=
 =?us-ascii?Q?NSA1dIJjpugmIp9eddBg6IvJrjEChSdmyubuVTtiprzBGKztiN89mb8BRRsu?=
 =?us-ascii?Q?LYhtFwIEfR0Z7b0neJOtdDwvyxpIKGw9oRP6FnNq6k8KhVeAOfEsHKFPzMIC?=
 =?us-ascii?Q?IvCOLUDts5E8WrVoWjaz8QQg9SbRo/TNsatBaUE4a1IJL/IyUYezIkUuf+j8?=
 =?us-ascii?Q?D+jr1sv1th40lPE4BGUuPtjUIk11RUYa/r3V9Cck/ebqO3/yd0kAsp7VWXDl?=
 =?us-ascii?Q?J+zZ+dDTuEQpS+0wCzF3/0BTi5zw0GSivwJIqjZNmL4ZBDsvxKt0AjZzAsPd?=
 =?us-ascii?Q?4ReROJBHeZbF2yXxttBf/ga4uAB5qhhPbcTHvNF4GrrPFsKuErlbMEM3GHTp?=
 =?us-ascii?Q?SVwNOcl7UuMg79J85kevHIrDBVn3zRLjHa6nwfkCRhhrpcDecWIFHnPvGgTK?=
 =?us-ascii?Q?Z6BwDTurL45YetZGyEO8zZ/AsLGhFFyH5tsJKhjY5tv/bTw/xUy7TC8+0wRV?=
 =?us-ascii?Q?93QENAH8qSuaVXrhg7ctPetkwlhF8k6I0r8l06RSfsECU8ktEunMHrTFZbZZ?=
 =?us-ascii?Q?jmbvPvhZ7UQJvZZCXFUd8Dtf1CCn45epjgczlTDS1Ttc0JtCkFCbxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 20:17:27.2653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb65c31d-18a2-4740-7399-08ddf494e3f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Fri, Sep 05, 2025 at 01:48:24PM -0500, Nathan Lynch via B4 Relay wrote:
>> From: Nathan Lynch <nathan.lynch@amd.com>
>> 
>> This was added to the PCI Code and ID Assignment Specification in
>> revision 1.14 (2021). Refer to 1.19. "Base Class 12h" of that document
>> as well as the "SDXI PCI-Express Device Architecture" chapter of the
>> SDXI specification:
>
> Would prefer if this said:
>
>   Add sub-class code for SNIA Smart Data Accelerator Interface (SDXI).
>   See PCI Code and ID Assignment spec r1.14, sec 1.19.
>
> so the antecedent of "this" is here instead of in the subject and
> "1.19" doesn't get confused with a spec revision.
>
>> """
>>   SDXI functions are expected to be identified through the SDXI class
>>   code.
>>   * SNIA Smart Data Accelerator Interface (SDXI) controller:
>>     * Base Class = 0x12
>>     * Sub Class = 0x01
>>     * Programming Interface = 0x0
>> """
>> 
>> Information about SDXI may be found at the SNIA website:
>> 
>>   https://www.snia.org/sdxi
>
> I don't think the SDXI spec material is really necessary.  The PCI
> Code and ID spec is definitive for class codes.
>
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks Bjorn, I have made the commit message changes you've suggested
and incorporated your ack for this patch.

