Return-Path: <dmaengine+bounces-9589-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLOoAJUowWmbRAQAu9opvQ
	(envelope-from <dmaengine+bounces-9589-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 12:48:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54B2F16E1
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 12:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5DDC302A7EC
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 11:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3EB39B498;
	Mon, 23 Mar 2026 11:48:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022125.outbound.protection.outlook.com [40.107.75.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F6396B66;
	Mon, 23 Mar 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266512; cv=fail; b=hc8fUpIJFFcHjYyaDApY54ukoma/o9xIP1L9XNBt4xgSCI5X6io926/eTHPeqJa9c1Vuy7lqltgDBylyRZ300GdTmjn6wOQ2IaQbCgfdYsiclUt910h9/aCsFMOS59qXBmuVWOcGLDBmyb5roiI91yOR11YtZKVaOSlcKoyxA+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266512; c=relaxed/simple;
	bh=L1LBx2+VbRadbRBmZr1ZtKXicGvwNEdHskvEYOVaX44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecHMZxBzssAo7SONIXk0r+xAMcKLOHTcfC/ZUuUo0zv3BgB9dbRSuE+e5OnTKzPnxaY7r9KoEurV9jQJr1FShcFo1jNNX6ql2TLWHhMjeJvB8cDd6nomJXk8sX3WtImPT0CYJFeKceCBpmQa3dcHgWoz7Z3UWXN8NZxlzFgpEfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+1JPBpSQVyqqK9x5iRm7pBRMhz6aPT+h/xmsa3X93+iJsAdnAOFnXVo8EwRnqjZWQ2xS4kJZ5y1e5lZJuDAwCFv33Hac4YdDH6MzIWoNmq9adulZkIY8o21oCBzxSs1F8RpgEU/efscGQ/5weVlqDXNF1DBu4VIXZo6bHGkmQN4rxhBNmOUi3i+pJGxDspetTT098lT9Eq2kdSSFsLvVEQL3MjcSdGJ5vu0SWsr7W+j1w2UnC5Ns+rZqkTV3VMm0pdsq/IYD2ZyvdwuDaE1HDRMVJ0a22HGye64sCdtMQivkxd0lhXkcxOYTPoUkU6sDL8Y2tYma1dSmygQ4ificg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN7h4RZni1BbiVdkXKt8OJJmCqr8fkwBfZrXXPMVjUo=;
 b=CTsvPguNWV+RIRZyOzAbr3QQbdfi1eqQ6/cu6jYZ77fd0sACLQFkR6PScwhPspQctNP5p1ujuj5MEcwPkp5lPfa+DONUBtPjCWmYMG0AOe8gzLh9XMYD7Ori2JRfYKv0D8BRWPOAbaaI4qtp0/jOLpf0n54wgsM/UEPlkmXtFevVv66i/2YRxggTfzl4UTsK92XQAX0fahDBoVU90vnBOgNCQSkRb/p5hCyyigCAko1YKMiysL9UFqQeJ+bTF3H7jPMYJ6WWsQIvG6AvLQHpLK1HgzVFbBHgsUwj812sKRV6Veg/0bxiihrqN+Wxx9ZMpY+mEl/ojzoVnN7mnlXQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR03CA0095.apcprd03.prod.outlook.com (2603:1096:4:7c::23) by
 PS1PPF77E02AF72.apcprd06.prod.outlook.com (2603:1096:308::256) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.25; Mon, 23 Mar 2026 11:48:27 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:4:7c:cafe::c3) by SG2PR03CA0095.outlook.office365.com
 (2603:1096:4:7c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:48:26 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3DDC34126F96;
	Mon, 23 Mar 2026 19:48:24 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	robin.murphy@arm.com,
	Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v4 3/3] arm64: dts: cix: add DT nodes for DMA
Date: Mon, 23 Mar 2026 19:48:22 +0800
Message-Id: <20260323114822.1925869-4-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323114822.1925869-1-jun.guo@cixtech.com>
References: <20260323114822.1925869-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|PS1PPF77E02AF72:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d939c5c7-7c54-4496-c8d8-08de88d21846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tfhsB0zPyWZXb/xsulKcB443iEVVMGr6pIat4QvXH0XBAfylIRLS2QZjv2ro5ol7Sez5SVSUAwRsczg5oDhLQTQWndzbARXHScRO53q5T8UFEwstB8tOFQP8bFDJpy15exMIqxG4AyENBkDu4DpAuw32IaMK/pfXiVfiSaWuV2ePVU6y5ZMo+PZI/IBREdvUJXRy3HfG5AddHg/uocKSmfRSQa9c1xqOg9GMpxYbnhwrgA8gdURys19V6ggX/kRdWeSLNo+LJQPwYT0MW/TiNom+EuXBD4FFS0Vjdcx778/c2GpsUAaHjNXO2BhmCGhmQpe1UkdBBDTXCZcFVP0/f+ISwzZr74dJcgUOBUPQm7NfICaX0Ul7RTHIfzPbprr25AuELXloGZ27bSd3OboHsALUAfZLiiKoBUFwG4X1VMrGmlDP92yOaDw962aeHS57nDvxiDnVPcto4gjMh2vyghq3HAF2UMoQ9gt+oXhXGq7qf+T03Fczco+e/iwhYgc3bQRejbRpdBbycFy+dnCBKSIPmKRtVevS9KWF6X1/hPoHpn6ZVUVXmOd6AS9yYYMnHzGZPPdUzaoOqMhL2jWdb+n347Heum8IuK0LvdW6MouPxa5DmWqw/HZbfOm71IkEVnlZtuE0c77Rq0WlRc7UmuKhkowdgr9+4X/MJsJAJ+H85ZHw7igm40XM99zV8RA150fs9ESWdaSWYm5AaGw1XEXBMnW3s0x7qAedBpjcDIluSJ76+SYiVl2J00fjehkTlfZlcTu4rHo2RPjUek/aSgzHILEztv1HLgHJZUkg7KzE8kDw4jpoMuAWr3Tz3Jjr
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tQn6pb33BV+ONzL1M4q+RrKc86iCZTnKb3PPiF7pZhe16wi7V9tikxybNQqzYH3/djKST+pSKGQYihhn2F5o2luUtLvVt38QIIYsTbWdYuh52zRn20wNCbHIedgZ7jJaQnfWpgqomEbDOPkxLsp/Ehn5mfy6QIVXMhFQb24tPf4KvAk2MS1UAHSVTwl7A/UQLX9LkXP2KvfXvc75GXxpKXcy5p4uYVNySMG/DdoyvJ4K+LKQ7yS/a9ZBlQuyXZ1UlfbQj4n2vXLWZQJ1UThR2MYwd4tNjOwWKqLiKpLOG5IVfxHj0u7CK8dB/RQrevSwyBFoVUjYv5eTVJWupbFQEwLyJEgbGkPc/EC00XxLT/pAm/M0ROtJ8jXsBeGDMVJM52ve5wG7Ecjnw+PCd0ZI7AP8rWxHYCnmMF3Wt7XoE376cBLELBHf0KcTCt54TJ2u
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:48:26.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d939c5c7-7c54-4496-c8d8-08de88d21846
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF77E02AF72
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[cixtech.com];
	TAGGED_FROM(0.00)[bounces-9589-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.77.53.160:email,0.63.161.16:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.63.239.48:email]
X-Rspamd-Queue-Id: 6B54B2F16E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the device tree node for the dma controller of the CIX SKY1 SoC.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 210739beac6d..1185c99d8d9d 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -480,6 +480,13 @@ iomuxc: pinctrl@4170000 {
 			reg = <0x0 0x04170000 0x0 0x1000>;
 		};
 
+		fch_dmac: dma-controller@4190000 {
+			compatible = "cix,sky1-dma-350", "arm,dma-350";
+			reg = <0x0 0x4190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>;
+			#dma-cells = <1>;
+		};
+
 		mbox_ap2se: mailbox@5060000 {
 			compatible = "cix,sky1-mbox";
 			reg = <0x0 0x05060000 0x0 0x10000>;
-- 
2.34.1


