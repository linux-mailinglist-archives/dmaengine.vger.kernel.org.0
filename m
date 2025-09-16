Return-Path: <dmaengine+bounces-6585-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F8B5A366
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B45F3A1E69
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998EF31BCB7;
	Tue, 16 Sep 2025 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XwPmf7+6"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163631BCA3;
	Tue, 16 Sep 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055228; cv=fail; b=DLigrimVwD+NdsI9VjOsarqOrOoiwDqkslBxvXiaAfvSwnqUkDgpcxntqWXp8WtchLyDvcih6WNkrihYKtFTV5mRT74Pqn+DU89YGvKDbfZcfdhB2nVdiCdsvG+kPxr2AGUrIqYBgPNJLJssxRAQvFrYofwpmdwgv075/igjWlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055228; c=relaxed/simple;
	bh=jAsKY+p/lzDK1S37c/fjbqQ1a4tBfGnOTYVkeIcXjAw=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPQH/3MuKD5qJoaco+qeP2IwHAvni34xZlujHuir2tTs0UrlPOvHvMT8b/OjpQJhL2E4ndEidynZE8gnYvyPG/7Ufy1TJDPckc18YOlGeo7oZNURF5wLPcTQhTxgF5cKS1FdfpcVsA8vCQLJt31Ieu1DsQmNJFX2/C8UQ3QjwTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XwPmf7+6; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJpeuOs7K+knBJpYfXGXP69CfNkDuWQlwwskw6U8MoMv8ZtHtuoqcKIwzCzzhP2IFmc3vyze84EI6xKh85CaFM5BJmg2iuvRLkNpw7eLy2fz3nkfvnJev5fEmMLbygeimef2tObWxnETzYlOTF+Wp3oa+fA7IejqDlAtZ49pvAGgFlWHDAo30/X4PBe2tc/ouD5H1NV1i79Y6kMFVnigB7oX+hR0k2P+hI44MgfP18m7AYzRWh2Z67r+Gc/DLTEZaMuk7bqaX+R+jpXBOqSPqCAqQDdEjeGN6AqeFYoZOWNNCrS4YEGPsrTWGXLQRY6UoZe+pD3lSGjzMA9bDgP8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+7X+nngBAI7T6NRV9aLgPy04CrqFx1yFtsCdf+A8XQ=;
 b=JXSzCGf8TnVh8zOeedwFpI8mXiiyK9/0jnVJDG2W6HKZFxAa4BaJZXaJWjV0UmrKIaRluCKsM/zn/J/GGk0aMkELApD2cNhzgwr4DKk8oIrSvwbkifHbcgxJoDE2j6MRMIfqn/4tXkgM69Qd05EVjaP9TBPPGwUfwPB9LGiy6iHoHqcAEStQpg5rNGt8YEwcvVkZCCbym+e1wDa1z8gRzAYnjjsnP6s12F5wyNeL8F7cNzEkZfKxeNzSNj1zR++bktI/XOSjzMjmFZd4MciHpRtnSaphJd0RnO1y+OkUbA0wE4Zozacf87IA85hpSx/uPOWz9isixT3WGY1ZrOaRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+7X+nngBAI7T6NRV9aLgPy04CrqFx1yFtsCdf+A8XQ=;
 b=XwPmf7+69YJ8Zbi6nCSdioRQ/dcTpj96SOoNcOAXXkUmcXSBTR5LNtXL+8W+XtYEDmqRHuQWG/aXu4u+3BC0No6U4CEM+eDl+M7lMeMfinPN5eNywi/LF1T3isD4kgL244n+uDWSQ46g83NP6jnoAvEUk5pfksFmZB2u4ARKmio=
Received: from SA9PR13CA0024.namprd13.prod.outlook.com (2603:10b6:806:21::29)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 20:40:19 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::b2) by SA9PR13CA0024.outlook.office365.com
 (2603:10b6:806:21::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Tue,
 16 Sep 2025 20:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 20:40:17 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 13:40:16 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 08/13] dmaengine: sdxi: Context creation/removal,
 descriptor submission
In-Reply-To: <20250915151257.0000253b@huawei.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-8-d0341a1292ba@amd.com>
 <20250915151257.0000253b@huawei.com>
Date: Tue, 16 Sep 2025 15:40:10 -0500
Message-ID: <87a52uxhat.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: e00794af-edeb-42e1-89fe-08ddf5613f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nyF154hcooTa4hcLkZSZFS6w/m5GUefb+AArxgD6xfppLvDu0f6GGASo9pOX?=
 =?us-ascii?Q?FKh05j1fOtqAjHoaX11KlnPdh4PFsd7iR6D7L9Y+yFFNyd4ezmd5AY/qpaw+?=
 =?us-ascii?Q?FpPu8Pg8ppUjA1k6xwCG8PtIOkGaiot0WXzSe5fYJVechPKq1KtudO+r7O0v?=
 =?us-ascii?Q?BLr2mLrxQmrpRGgR7MAqBOLI7sdTVrsOai18raBcTYJhcweHdt2OgZntVKgq?=
 =?us-ascii?Q?v7XhNRTj180bW/N4zjBpS0RZq5fLTPNUbM2Io08Yc8RSxejHAdoMwNkiyNiG?=
 =?us-ascii?Q?y2EBwtsqevzNJokGx1tO9vK03jGQrcgwn8u9yq1QYu/gQqzxWqgq7bamKj1y?=
 =?us-ascii?Q?+7KEpI69CnUEckDV21s3g2lefsHyhzPxVYKZ/1qiBvSZsqOuwx6rjIfP/EHZ?=
 =?us-ascii?Q?N6QcTE0F6mg1/u+vo9NXLU5hP/Zb5UefFTnUT3/xJNRcJlxzirbDMaX3yjt3?=
 =?us-ascii?Q?6JLq6X2XN8m74ikGYD1QoM6AZvB3FhGLxL3r3KslOs3HhSjObjhrm/3qNH1o?=
 =?us-ascii?Q?5T/g/BWSoDso97j/VnfuGOyTQZ8pDCKicCigmlMfyngCH+IiqMjnslcfFG6/?=
 =?us-ascii?Q?kVPIn5Sxcy13js6SGFrIhHt57g7gb9bPCNdPgZfqp48IgND1GgW9b6NLnyoX?=
 =?us-ascii?Q?2a2Tx4+fTUUryfBDSiY7t5RCDxBq5ZzzgNhgvqXbmAE/k4cl5do7jaaT/leq?=
 =?us-ascii?Q?PCH4hs9W+8THdelPQ5fPF2mDekipo055Y4nXWxLGtyNTFnw6TER848q63ERs?=
 =?us-ascii?Q?7yRtY0g04s1BDE7KrZNFKZ6ZsRcNCULBvbsYKXfe2NBHSEUor+UMVW6pnBo4?=
 =?us-ascii?Q?15h6ymYOyjGC1Wh0Zdg3uXIlQcu7T7wa0EkQjc5Xp4bxOy3y0wiRjD+f4o/o?=
 =?us-ascii?Q?CdZl0kx8yTdhL66C9+e+Oxu3PE9RxxkQs+7PSmM3anwYNBPZBS4WOA4ruYaS?=
 =?us-ascii?Q?byADIGdF7sWhhpyodrDGdo2Y6/va03WYGE0L43W6oAkahcc38C/jr5Lj6m9F?=
 =?us-ascii?Q?+5HyqTd00W3AJaj7DhF1PuQteWSl4827M6/+itYjpUUetg0TC5jDXWC81VQ+?=
 =?us-ascii?Q?bAIayf+56+LQJ/hbGBQP29N+c3PjocX7U8rM7s4mMW8M08r5VAsR0cXl7lbo?=
 =?us-ascii?Q?wmJvN5Ht8m7t+UiUoE7IjoGUmTNMl7Yi2yEfxrbyEFiYw/BxZipH4qJLo+Oi?=
 =?us-ascii?Q?KCs4lAOMMBsYPN1l7NfUSnGNgWnmAbmIjSjLcNQYw81jvoY/esgyx0AURSQ+?=
 =?us-ascii?Q?rYiXgoOB7uXafhz5w214eP08VmtYPZxxjWkgrADlMkuJPg4IQPLpm/hhGX8k?=
 =?us-ascii?Q?5PSZ7xjahZp/O67HXbqbPnFyujW5pfHNbDRkfvhL8o4cV9cipdQtuefiZGfR?=
 =?us-ascii?Q?MOw3woy/KX/Pm2xtWFwkednQgyhvkDFLyDlKAYXkLThRwgkRg3IfCym95PNT?=
 =?us-ascii?Q?1tmdF8+6hB85gplWh2qff2rLnUTkycXzulwoxHZB6AgLYOMJDLKRH70vVtbt?=
 =?us-ascii?Q?JoIHDdvKeYq+qcyBX6w/K3MA7wcORuAAk3jW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 20:40:17.5291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e00794af-edeb-42e1-89fe-08ddf5613f18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827

Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> On Fri, 05 Sep 2025 13:48:31 -0500
> Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:
>
>> From: Nathan Lynch <nathan.lynch@amd.com>
>> 
>> Add functions for creating and removing SDXI contexts and submitting
>> descriptors against them.
>> 
>> An SDXI function supports one or more contexts, each of which has its
>> own descriptor ring and associated state. Each context has a 16-bit
>> index. A special context is installed at index 0 and is used for
>> configuring other contexts and performing administrative actions.
>> 
>> The creation of each context entails the allocation of the following
>> control structure hierarchy:
>> 
>> * Context L1 Table slot
>>   * Access key (AKey) table
>>   * Context control block
>>     * Descriptor ring
>>     * Write index
>>     * Context status block
>> 
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> Some superficial stuff inline.
>
> I haven't yet reread the spec against this (and it's been a while
> since I looked at sdxi!) but overall seems reasonable.
>> ---
>>  drivers/dma/sdxi/context.c | 547 +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/dma/sdxi/context.h |  28 +++
>>  2 files changed, 575 insertions(+)
>> 
>> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..50eae5b3b303d67891113377e2df209d199aa533
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/context.c
>> @@ -0,0 +1,547 @@
>
>
>> +
>> +static struct sdxi_cxt *alloc_cxt(struct sdxi_dev *sdxi)
>> +{
>> +	struct sdxi_cxt *cxt;
>> +	u16 id, l2_idx, l1_idx;
>> +
>> +	if (sdxi->cxt_count >= sdxi->max_cxts)
>> +		return NULL;
>> +
>> +	/* search for an empty context slot */
>> +	for (id = 0; id < sdxi->max_cxts; id++) {
>> +		l2_idx = ID_TO_L2_INDEX(id);
>> +		l1_idx = ID_TO_L1_INDEX(id);
>> +
>> +		if (sdxi->cxt_array[l2_idx] == NULL) {
>> +			int sz = sizeof(struct sdxi_cxt *) * L1_TABLE_ENTRIES;
>> +			struct sdxi_cxt **ptr = kzalloc(sz, GFP_KERNEL);
>> +
>> +			sdxi->cxt_array[l2_idx] = ptr;
>> +			if (!(sdxi->cxt_array[l2_idx]))
>> +				return NULL;
>> +		}
>> +
>> +		cxt = (sdxi->cxt_array)[l2_idx][l1_idx];
>> +		/* found one empty slot */
>> +		if (!cxt)
>> +			break;
>> +	}
>> +
>> +	/* nothing found, bail... */
>> +	if (id == sdxi->max_cxts)
>> +		return NULL;
>> +
>> +	/* alloc context and initialize it */
>> +	cxt = kzalloc(sizeof(struct sdxi_cxt), GFP_KERNEL);
>
> sizeof(*ctx) usually preferred as it saves anyone checking types
> match.

yep, will fix.


>> +	if (!cxt)
>> +		return NULL;
>> +
>> +	cxt->akey_table = dma_alloc_coherent(sdxi_to_dev(sdxi),
>> +					     sizeof(*cxt->akey_table),
>> +					     &cxt->akey_table_dma, GFP_KERNEL);
>> +	if (!cxt->akey_table) {
>> +		kfree(cxt);
>
> Similar to below. You could use a DEFINE_FREE() to auto cleanup up ctx
> on error.

OK, I've been hesitant to try the cleanup stuff so far but I'll give it
a shot (here and other places).


>> +		return NULL;
>> +	}
>> +
>> +	cxt->sdxi = sdxi;
>> +	cxt->id = id;
>> +	cxt->db_base = sdxi->dbs_bar + id * sdxi->db_stride;
>> +	cxt->db = sdxi->dbs + id * sdxi->db_stride;
>> +
>> +	sdxi->cxt_array[l2_idx][l1_idx] = cxt;
>> +	sdxi->cxt_count++;
>> +
>> +	return cxt;
>> +}
>
>> +struct sdxi_cxt *sdxi_working_cxt_init(struct sdxi_dev *sdxi,
>> +				       enum sdxi_cxt_id id)
>> +{
>> +	struct sdxi_cxt *cxt;
>> +	struct sdxi_sq *sq;
>> +
>> +	cxt = sdxi_cxt_alloc(sdxi);
>> +	if (!cxt) {
>> +		sdxi_err(sdxi, "failed to alloc a new context\n");
>> +		return NULL;
>> +	}
>> +
>> +	/* check if context ID matches */
>> +	if (id < SDXI_ANY_CXT_ID && cxt->id != id) {
>> +		sdxi_err(sdxi, "failed to alloc a context with id=%d\n", id);
>> +		goto err_cxt_id;
>> +	}
>> +
>> +	sq = sdxi_sq_alloc_default(cxt);
>> +	if (!sq) {
>> +		sdxi_err(sdxi, "failed to alloc a submission queue (sq)\n");
>> +		goto err_sq_alloc;
>> +	}
>> +
>> +	return cxt;
>> +
>> +err_sq_alloc:
>> +err_cxt_id:
>> +	sdxi_cxt_free(cxt);
>
> Might be worth doing a DEFINE_FREE() then you can use return_ptr(ctx); instead
> of return ctx.  Will allow you to simply return on any errors.
>
>> +
>> +	return NULL;
>> +}
>> +
>> +static const char *cxt_sts_state_str(enum cxt_sts_state state)
>> +{
>> +	static const char *const context_states[] = {
>> +		[CXTV_STOP_SW]  = "stopped (software)",
>> +		[CXTV_RUN]      = "running",
>> +		[CXTV_STOPG_SW] = "stopping (software)",
>> +		[CXTV_STOP_FN]  = "stopped (function)",
>> +		[CXTV_STOPG_FN] = "stopping (function)",
>> +		[CXTV_ERR_FN]   = "error",
>> +	};
>> +	const char *str = "unknown";
>> +
>> +	switch (state) {
>> +	case CXTV_STOP_SW:
>> +	case CXTV_RUN:
>> +	case CXTV_STOPG_SW:
>> +	case CXTV_STOP_FN:
>> +	case CXTV_STOPG_FN:
>> +	case CXTV_ERR_FN:
>> +		str = context_states[state];
>
> I'd do a default to make it explicit that there are other states. If
> there aren't then just return here and skip the return below. A
> compiler should be able to see if you handled them all and complain
> loudly if a new one is added that you haven't handled.

The CXTV_... values are the only valid states that an SDXI device is
allowed to report for a context, but this function is intended to be
resilient against unspecified values in case of implementation bugs (in
the caller, or firmware, whatever). That's why it falls back to
returning "unknown".

But it's coded without a default label so that -Wswitch (which is
enabled by -Wall and so is generally active for kernel code) will warn
on an unhandled case. The presence of a default label will actually
defeat this unless the compiler is invoked with -Wswitch-enum, which
even W=1 doesn't enable.

I really do want warnings on unhandled cases of this sort, so I suppose
at the very least this code deserves a comment to deter well-meaning
people from trying to add a default label. Or I could add the default
label and see how painful it is to use -Wswitch-enum throughout the
driver. There are several similar functions in the error reporting code
so this isn't the only instance of this pattern in the driver.


>> +	}
>> +
>> +	return str;
>> +}
>> +
>> +int sdxi_submit_desc(struct sdxi_cxt *cxt, const struct sdxi_desc *desc)
>> +{
>> +	struct sdxi_sq *sq;
>> +	__le64 __iomem *db;
>> +	__le64 *ring_base;
>> +	u64 ring_entries;
>> +	__le64 *rd_idx;
>> +	__le64 *wr_idx;
>> +
>> +	sq = cxt->sq;
>> +	ring_entries = sq->ring_entries;
>> +	ring_base = sq->desc_ring[0].qw;
>> +	rd_idx = &sq->cxt_sts->read_index;
>> +	wr_idx = sq->write_index;
>> +	db = cxt->db;
> I'm not sure the local variables add anything, but if you really want
> to keep them, then at least combine with declaration.
>
> 	struct sdxi_sq *sq = ctx->sq;
> 	__le64 __iomem *db = ctx->db;
>
>
> just to keep thing code more compact.
>
> Personally I'd just have a local sq and do the rest in the call
>
> 	return sdxi_enqueue(desc->qw, 1, sq->desc_ring[0].wq,
> etc

Yeah, that makes sense.

>
>
>> +
>> +	return sdxi_enqueue(desc->qw, 1, ring_base, ring_entries,
>> +			    rd_idx, wr_idx, db);
> 				
>> +}
>> +
>> +static void sdxi_cxt_shutdown(struct sdxi_cxt *target_cxt)
>> +{
>> +	unsigned long deadline = jiffies + msecs_to_jiffies(1000);
>> +	struct sdxi_cxt *admin_cxt = target_cxt->sdxi->admin_cxt;
>> +	struct sdxi_dev *sdxi = target_cxt->sdxi;
>> +	struct sdxi_cxt_sts *sts = target_cxt->sq->cxt_sts;
>> +	struct sdxi_desc desc;
>> +	u16 cxtid = target_cxt->id;
>> +	struct sdxi_cxt_stop params = {
>> +		.range = sdxi_cxt_range(cxtid),
>> +	};
>> +	enum cxt_sts_state state = sdxi_cxt_sts_state(sts);
>> +	int err;
>> +
>> +	sdxi_dbg(sdxi, "%s entry: context state: %s",
>> +		 __func__, cxt_sts_state_str(state));
>> +
>> +	err = sdxi_encode_cxt_stop(&desc, &params);
>> +	if (err)
>> +		return;
>> +
>> +	err = sdxi_submit_desc(admin_cxt, &desc);
>> +	if (err)
>> +		return;
>> +
>> +	sdxi_dbg(sdxi, "shutting down context %u\n", cxtid);
>> +
>> +	do {
>> +		enum cxt_sts_state state = sdxi_cxt_sts_state(sts);
>> +
>> +		sdxi_dbg(sdxi, "context %u state: %s", cxtid,
>> +			 cxt_sts_state_str(state));
>> +
>> +		switch (state) {
>> +		case CXTV_ERR_FN:
>> +			sdxi_err(sdxi, "context %u went into error state while stopping\n",
>> +				cxtid);
>> +			fallthrough;
>
> I'd just return unless a later patch adds something more interesting to the next
> cases.

Agreed.


>> +		case CXTV_STOP_SW:
>> +		case CXTV_STOP_FN:
>> +			return;
>> +		case CXTV_RUN:
>> +		case CXTV_STOPG_SW:
>> +		case CXTV_STOPG_FN:
>> +			/* transitional states */
>> +			fsleep(1000);
>> +			break;
>> +		default:
>> +			sdxi_err(sdxi, "context %u in unknown state %u\n",
>> +				 cxtid, state);
>> +			return;
>> +		}
>> +	} while (time_before(jiffies, deadline));
>> +
>> +	sdxi_err(sdxi, "stopping context %u timed out (state = %u)\n",
>> +		cxtid, sdxi_cxt_sts_state(sts));
>> +}
>> +
>> +void sdxi_working_cxt_exit(struct sdxi_cxt *cxt)
>> +{
>> +	struct sdxi_sq *sq;
>> +
>> +	if (!cxt)
> Superficially this looks like defensive programming that we don't need
> as it makes not sense to call this if ctx is NULL.  Add a comment if
> there is a path where this actually happens.
>> +		return;
>> +
>> +	sq = cxt->sq;
>> +	if (!sq)
> Add a comment on why this might happen, or drop teh cehck.

Yeah we can probably remove these checks.


