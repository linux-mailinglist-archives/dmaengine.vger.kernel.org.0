Return-Path: <dmaengine+bounces-10503-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEhfHrbICmqf8AQAu9opvQ
	(envelope-from <dmaengine+bounces-10503-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 10:07:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058D56865F
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 10:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C87E03026039
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD250346770;
	Mon, 18 May 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nCUEs4wk"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57E3E00A9;
	Mon, 18 May 2026 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090770; cv=fail; b=pV21DP85wNLGfvyBb9xj9yKJpBUj7S37J398zzufwfeDDHaDAohEzwltiz/dpBumyUoUs4Nhvd3yWhOscYi8PqsPd+hu8ptdZQDa4+d7ez/fXeiadvM9GBaJ94zS49gW7bvfoDCwp9aB/oRVyy+Ad52Lhn2cu6JtStkHq36wc6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090770; c=relaxed/simple;
	bh=q57q8tmWl7YPZfqI8Lo55ozJsZhNvr8kY4nqSMQ7nvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=cXs7dHLBY6R5sQBrM1GK65/sGYXHX+21bEkaNOJT17NilO9mBH+fUYJuzqKSVctU2HYMAvolo2h+rcdjbvZFqsEpvE8aAt7YxQXfygXIbJVX8kQMd2Oulk9meMMBIkcYsA5z1mUpagv4S6oedRnO0cXmp+UErCyYFnnXHJSIbmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nCUEs4wk; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUk7EHGakKpcI542IheWji50xmphsoEQEmO6VxWfFWkhvWHTvOw+ooQKOL3ZOqWDXaTOvoekI6Xeq3nsxIbtdKAR9dU1ZWa6NTdLTHj+ScK1f9qTw1UHrom6kQREoEbFuTKcTQur3L7gYDQctTgW8uJru+z0/zQtTAJaJyqXAongawz8f6j4gIRkeM7Mz+il7b8TnZRmzF3KMergtWfckSTvP+1nYm4eGiDLRwG/9suw9h3vCF2yH0yuNX6p6CcSB3FnyK/Hm9UE4wbPSRE4HFaRLb3/obtiYHj2SDUea5TGYoZNkT1JMgBBYljS4yp6N7b7vdMe+K3Umy1RNFm3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hyEryPda4Nm9OVv8qkX+2WDoRdKPbCxtyeMSoAipaI=;
 b=TetucrXh4I1qiB6gCGCuC4iY2Jdkqwx2+RBYTVHJd/Kkh8za4PASWoMniB7eltsUn3klfQSNjr41isKde9jompI3EG4k/j/5Mfb1qAOhu8wT28hG68PMua0xFuZksG5eLfOm3PnQAt90VJalKfO0OFI8DQ+xEHuaB8fJEncxryr6TP5kxkXZCEYcy3Nckl8eBNtYq7JrAt8W6Azf4NpxYuLjkZ++uuErdlWUd34+KC3PJcA3X+8kd2woYQjysQ9CwjpYQbiZYOwBhqLADlk2KawM3PE2hHWI340ai64V389uM5ty83vEuUfP73k2qiU+qtkEJfM1XXYgcPqHWEdfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hyEryPda4Nm9OVv8qkX+2WDoRdKPbCxtyeMSoAipaI=;
 b=nCUEs4wkcYHpjM96KmmO2GRSCxqM0AISelDZsWNZr28MbAbYJWx1+j39T6MvQ4NHaYzPnko+utiepbojRwxVu96CVkk7i2O0PBMibBPLl49otSRbpIOrkhcf9NdlpZromXyjA0tpuJGz34WNzGU9jPS07OVObORtwltnx4H3vR0=
Received: from SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 07:52:36 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::50) by SJ0PR05CA0104.outlook.office365.com
 (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13 via Frontend Transport; Mon, 18
 May 2026 07:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:52:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:52:33 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Mon, 18 May 2026 07:52:07 +0000
Subject: [PATCH] dmaengine: Fix device kref underflow in dma_chan_put()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com>
X-B4-Tracking: v=1; b=H4sIACbFCmoC/x2MWwqAIBAArxL73YJK9rpK9KG12RJZKEQg3j3pc
 xhmEkQKTBHGKkGghyNfvoCsK1h24x0hr4VBCdUKLXtcT0PesSc8Am248YudVdIsVgyN1lDCuwh
 +/+k05/wBu0V5xGQAAAA=
X-Change-ID: 20260518-dmaengine-kref-fix-7b21acb09455
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shivank Garg
	<shivankg@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779090753; l=1738;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=q57q8tmWl7YPZfqI8Lo55ozJsZhNvr8kY4nqSMQ7nvU=;
 b=TmUirHS9SQvQKZjDSut0BLy6PE4X05TVe6kH3SCtVn5ubHA0KMW33+kQ8i80UX7WitdPWtYsY
 1Plt+CzanPoC51HFVXoLjpKsegmxhroWTHUje8eCaUS8B7cRYWaMtPY
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4c9142-d119-4ed4-3944-08deb4b26d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	26Y3p84c5LsY1munCJCWWOFbCSoTtXEpb3zILxKw7GFDgIWOSZr2iSQdhHhA5ZSDxPDhgzFbxhRtRof0L9NYqstPUmggHZ7IOU1hazFqBjEfQov2wb/NnGx428AQwkrx1UYsCWKGtYnht+s0L0v1bBcPdOkMacKuOBdtIE2w64Gf9BrzhegJWHLQNhLBlcLXuJ9/1Vn1mmVZ7twRfQe4eB/UtO86RUiEN2vhRYPpudN5povyfwOdDJgG1y+Bg6HntcN5XOMqYWeZ6GsB2l8oucItNA9g86xzsfbUZhKsU/QrY1LqXbbj4dJu1G9YWgFGrPMCvd5wtuIjQFZ0VOBw0r8kH0I5ONSu7O5OzX38M3vznGJ6GAWh+JnRakReIJNw3NccquwDWJ2+AmKgkQKLxAwT4757ESzzpB7PTBgD5zGGK2orvWXJlHLkKMWtpD5ABNjR9a9AlVui4IdzUi212vOFJLQgXacoWUhCtdhUleaCD1Wvufkz5YpqY8iaEo32XfS5n5PNxnPi/jsXXYXVQF8SGgVh/7tRQYuUbRIcj8gLa443Q2I4xpkYsr7NVGKGxSb1D3bPxRMtRzNJbEhhld1Gg6GNSOcejd7guxvp0QSWb9HzHVDiMas0l6r4qnswYY//GqWJuWEBPJUHNnWrd/tQI+9neHjuGBvPy0Mp5thkg88IWHrmtgfyx4sFIRvyx6hzoygRxPUJbPU2G1HOHK02xmp1nu4TaZM2eLen7cY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eGfaEC0LVmF3/vOqjDT7WTOPKK2cTRtEoVFSaETPUHntV5KdaMV3w0ywN3fsXyMDCwNp/T90JrctfU+cJKjO4//f+h/Z/ItdHoPs3jiDihYIpLM8/Z60ITnzMnD1nE2KDY4YLgQoVrL+k5+FBUkJBwq1iPis57h+3xeB0Wg2SJFhj05+fg2nTGkoFO3j5QokIhgjsYwnBeHXqyI78XxjSWA2lD0K7MbZ6AqrNWuuiTOMG8O4M3rPyEBxoEpFQNWpSr/OlyLCkOx73ZxbSHW4cjH3GOH3a3Oq0VutgENgjZDnoiVKOAFqpdzMNzOOit/OkCrYOd+5hCDQqvm3Dr7Dakq0kvYmtTV+yWiHp1lKbsTesZryDCjurCc4XO+e0FREU3dPHDWfTg/kkoZX6BCF0DuU5X7E86XUkdEarHJ+dnf7E0LbSoS8BW+MZDLdwGH9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:52:35.9247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4c9142-d119-4ed4-3944-08deb4b26d13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
X-Rspamd-Queue-Id: 7058D56865F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10503-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[shivankg@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

dma_chan_get() takes chan->device->ref only on the slow path:

	/* no kref on fast path */
	if (chan->client_count) {
		__module_get(owner);
		chan->client_count++;
		return 0;
	}
	if (!try_module_get(owner))
		return -ENODEV;
	ret = kref_get_unless_zero(&chan->device->ref);

dma_chan_put() drops the ref unconditionally, so every fast-path
get/put pair drops one extra device reference.

The bug fires when two conditions hold together: a non-private
provider has a persistent client holding chan->client_count > 0
and another client cycles dmaengine_get()/dmaengine_put().
When the kref hits zero, the subsequent dma_find_channel() returns
NULL even though the provider module is still loaded.

Fix this by dropping device->ref only on the last put, matching the
single slow-path get.

Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 405bd2fbb4a3b94fd0bf44526f656f6a19feaad0..605bfa477a004cc0b03957ffb85a52308f903441 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -515,7 +515,9 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->route_data = NULL;
 	}
 
-	dma_device_put(chan->device);
+	/* This channel is not in use anymore, drop the device ref */
+	if (!chan->client_count)
+		dma_device_put(chan->device);
 	module_put(dma_chan_to_owner(chan));
 }
 

---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260518-dmaengine-kref-fix-7b21acb09455

Best regards,
-- 
Shivank Garg <shivankg@amd.com>


