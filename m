Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695324DCD0D
	for <lists+dmaengine@lfdr.de>; Thu, 17 Mar 2022 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiCQR7F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Mar 2022 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiCQR7D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Mar 2022 13:59:03 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F721C050;
        Thu, 17 Mar 2022 10:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMOe+JQb1YJ5SskBA/jVyh7rNBya69/118Td3ypxMBapWFJCJrpXPztv7GNSxj8mDtTKccbmXwf1H+UKbRNM/9l0a3zvChXC+2CcQ2vhnmVBTXG3/2ChAu9SCdpyTDyJZAajl84XX+gW4uckmVRcD/iNQcgb6QAeiphR6u0wJv8Aj0C175R9ltBlztUUZ19DZr25wfzqEX6QxccgmfpDFq0MPz/yztY+Z54yF9zDhMc/q0N2a1ywolDFgL+S7qxH60m1pAH5Kzx1WWYgssA1o5JZgKPM+yLWH4Uz5WGQ7jnn+HhbB62Z6aXHz4iCXtIp4+dUT0s8oSHhajEMzefpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyT/oBDWoihd793ivelDaQ579KDWya+ntMdoTZm0q9Q=;
 b=myxATR8dHL/xs1OMm1UoR7hGmm+mF2PSMSFp/s6l8EixVzDy2KDvmhmYowy4cXXao6Xn4C9fk+859aKuOEvqf42EjtOq9jAKWMO9XaI7QUQzXySaxJdMmWlFUwFla8gwhXZfs8pwlTNNn6ymjucpvEoOpvyy+NZNtqmrZxWtcqnyxUqCzigKizHiTdPePXR9c4vqyF96vRpAeTLskrdvURx5Y8pqEqDD/b3GvgalLFqAB32F+47ty0B9qoqVaX/c8SqBDq/YCpMIYD0ieqwGnOnbXhXZIzWYtolqL0ro+4zEYAuJXZ/lyxHhmqyGmSrTrX1YOiS8WAxKk/kEDD20pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyT/oBDWoihd793ivelDaQ579KDWya+ntMdoTZm0q9Q=;
 b=Oq9cibeAoL2FXlhJlhKdfWCRGMHBSjt00xmPAMlFwjXHjcIJmgQ/hGUXD36s3DfnVDHUVc+h728JlwTV+cWc48SAWORIC3S/17mGLE6fR1wDC06nUeIOAAfXyxq77ejNuNFbRkcr5GK9dyr5YXzspazqp5s9OHfs40Zze270DfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=orolia.com;
Received: from DB9P251MB0306.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2c8::20)
 by DB9P251MB0171.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 17:57:44 +0000
Received: from DB9P251MB0306.EURP251.PROD.OUTLOOK.COM
 ([fe80::8c51:a5d7:5136:9930]) by DB9P251MB0306.EURP251.PROD.OUTLOOK.COM
 ([fe80::8c51:a5d7:5136:9930%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 17:57:44 +0000
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Stefan Roese <sr@denx.de>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Olivier Dautricourt <olivier.dautricourt@orolia.com>
Subject: [PATCH 2/2] dt-bindings: altr,msgdma: update my email address
Date:   Thu, 17 Mar 2022 18:56:56 +0100
Message-Id: <dc3decf1dae172c688017bd3ada2ad2b7d060c1e.1647539776.git.olivier.dautricourt@orolia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <85c4174fa162bd946ccf3e08dcfc9b83cfe69b5c.1647539776.git.olivier.dautricourt@orolia.com>
References: <85c4174fa162bd946ccf3e08dcfc9b83cfe69b5c.1647539776.git.olivier.dautricourt@orolia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0096.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::36) To DB9P251MB0306.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2c8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc0a21a-d233-48dd-5b96-08da083fa36d
X-MS-TrafficTypeDiagnostic: DB9P251MB0171:EE_
X-Microsoft-Antispam-PRVS: <DB9P251MB017195AE8B94B4D3B19701408F129@DB9P251MB0171.EURP251.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUVuTWdihQYMtvb4N/tSJQ2VjPp/gtH99UD9lNiBoKKYq3UUmYzaQvxNgfZgUw6lilp3cx2JHk/KpXMwLLS5h/eXFpcm0ff/rgAgkCAtxXM/bbgOYapgWKH5KDBfaHYC2qRNEThJR00wxh5u0toNRIYiWKByNhK4fbD2k7VPw3aqHx3ZvWQcPXIhM3j2At5p8mguQLlYKu1APXdTM4fUuL6/OWStvtGYaXu3scO9kYe6h6iDnLqMYwxhx2o7eoS5wN+iLTwBxRTXuAuMQDrFYIQc3wO1oyNpIXX6aNE7O3XuEy4rTrO7Tu3hDD4YItZE9PwbpcY/rA2mo3Qj4GmEjG/WZq5i1Rx+ESeO7SyJPM7v9hrjvmA8uAb+jcnwEnh7gu7UdJ3zVC74EDS2usdElKrmqqP5lwmvtgqIPLxdK/eVxNbOdsaHzT6R+LRBUlOPNkmR2NnGsVv1QGq8WX9N/BAqAaESP9zQLtD8+iCu96K/4iQxS88ICX1d09DoKkpxo4+Hb7vbKH4Pyco9V8MjDIQ7sKHt4gvUAofYcrDnuJnELr2ppfrC9vG8wjFYTRWtt0tnqyo+gOSYQ58wPnjGxp4N87D9BrYlzpGZ/h8iGSATUNNGRrduyKC5J2Z+neMpCxarHpM1eIiSinXe9DQFsKYdSLEk+aogR/i+7Q5EVe1F4N+JSFoS2sbqnihWCG82g/UepueltJxJ1JvjAV1XMy1TOQIDL8UdB4U/sVGc+2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P251MB0306.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(52116002)(86362001)(2906002)(508600001)(6666004)(6486002)(966005)(316002)(6506007)(110136005)(186003)(107886003)(2616005)(36756003)(83380400001)(4326008)(8676002)(66476007)(66946007)(66556008)(38100700002)(44832011)(5660300002)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ZTjYVtj7OsqgExZKEGGT8StKHXzxA0WtLau5mUGaUV+lvG2OIXqPxMotSuL?=
 =?us-ascii?Q?z8q1owhDxj9n87X/cwJ4yXNpdKZp4lTlKPrp+vTpHy2gKDPdBPGJ9uyn+oCQ?=
 =?us-ascii?Q?c8bXair1907Cu7Qg36DyGijyDlbfDZT5hrXTwXmWipiiC/zGkIxVRV4zwFj6?=
 =?us-ascii?Q?2grj6BFeRTO0/Ut5Uh/zesG8cTW60ngbIdFbw8UfIYO/09qjAFDirIxNm2oG?=
 =?us-ascii?Q?f54Bu4J28bE4dVt9NFpwWtzuNsivgamI1L+UbRmTNJQanCaUXJBDMCGhraoG?=
 =?us-ascii?Q?jN/1AUQSk2nBgitC98+yKfn/JphrN81H/RtzKmPIEzMN7ouGLip33lQ0ubbR?=
 =?us-ascii?Q?3+MF5rLEX8NDv2wjusMU/WiWHrOl298j1l9Iicj15ZKLqW1u8YfbXmHEb2ik?=
 =?us-ascii?Q?m30aM71R8+vbkQFYT0ShgBrGDoqRHpVXUQlTVrbJWoT/B5jfyaRVOl2mfpdT?=
 =?us-ascii?Q?Esf9HoIM42MPEhX9DKa0cF9CTV01cj2bEdkEw78ztNhkN1T6ySnUlrNZSGHj?=
 =?us-ascii?Q?ueTmDTD0wRAeztGaQXzSLgxl204Yc7kyadolFLJusDF1efr5eb8g2cIGYAFi?=
 =?us-ascii?Q?Lg3Un2tkfsuZytQdCTujzlgsO89RHDjWu5CQVM3JrQ26P0ugiHqCQ/IxbGL0?=
 =?us-ascii?Q?oZ5it2lJCQq5yptJ9YuNfHMSvRpr3H3Ci9fGAbv58QZrsl8Taz8qPwBpSPeM?=
 =?us-ascii?Q?P1nr5yJqknabBf3KfPYgZfTnsDiE9Tfm7pS0aoPV+p75bLh3plB66PxDnQdV?=
 =?us-ascii?Q?GXgUPgxaQjAbeuXUXQQAzSG6j27+vS/gGEK/0kG2Weqi0uncnkMDAyDbftlK?=
 =?us-ascii?Q?57JE5vAOxkdj6JW61Ovj+TYZJpSFw8FTAzChcrK494+qeqiY/ltonossxZBx?=
 =?us-ascii?Q?FeCOs3PIfpUSHekp/oUJJ3qdivGbCsQ5IBfgVL+XRKA3bEw+t43HNJ6hJkvn?=
 =?us-ascii?Q?xibLLXQAqApoUVA6PCS2+iDIVuWXMFbDdsL26yU4ZWhJ4/xVVXNgV3yC5aVH?=
 =?us-ascii?Q?ibc5QiDr1tFznUNi8wcV6J6odrIBYw5tWJYX1HRhifXTCOw2vui8+r4LFhap?=
 =?us-ascii?Q?EFzpNK2+Ide9EIgiRIEmLxaQaDS+9e9fVOKNdRJBHYMF8bCc3ruqXbucnKL9?=
 =?us-ascii?Q?kNgHtrMgdKHuJRuBZNZtNjJ4KT11CehiXVh0XB1KxFY11oxWQ1ORDqVRRfG7?=
 =?us-ascii?Q?GRlq6iGLRty9NSnJRRAphcI0/erToQRRuyiFzTjeGM9ipWgxd6xEwN2JoYH1?=
 =?us-ascii?Q?nXNWW4IiEfxvciKrNy8LLcURFZ5hSSAGLTLT9zTqd3rQe5k4fA8ZlJVTObuq?=
 =?us-ascii?Q?zTVDvAey5hZPpWyOZWMXFbzl/zM90qqYv6MYcUTIzav/0laSVDwrGiQPRuO4?=
 =?us-ascii?Q?zA8bXzsCCHcQMOxfIjp/CcseDza/g5XPxtlkFq+nUtSfPdHSDqBfaXyUKv1d?=
 =?us-ascii?Q?AwbwMYiX9ngsFOvWHhtkW0kqhqZ+KTMY/5rtfvmXtX076pssqfz2FjVvXJzx?=
 =?us-ascii?Q?wJ5IYZwPlvNetLlZPI0O/kJWys6BXyETFl6+7wG2nT9NX80Y3FY0v6LoYkI5?=
 =?us-ascii?Q?zrhVYDLX9qELGzsEKBE=3D?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc0a21a-d233-48dd-5b96-08da083fa36d
X-MS-Exchange-CrossTenant-AuthSource: DB9P251MB0306.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 17:57:44.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG/q95FBXkVkJKNeI6Paioyih6dk1lGZsS5kNrkOZfUyD252dtpLxvhInryqmVCc5sPlslDPQV/tvsIiq+LDkAOeGigXAawH83S0S0yTsy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This email should now be used to contact me.

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---
 Documentation/devicetree/bindings/dma/altr,msgdma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
index b193ee2db4a7..b53ac7631a76 100644
--- a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Altera mSGDMA IP core
 
 maintainers:
-  - Olivier Dautricourt <olivier.dautricourt@orolia.com>
+  - Olivier Dautricourt <olivierdautricourt@gmail.com>
 
 description: |
   Altera / Intel modular Scatter-Gather Direct Memory Access (mSGDMA)
-- 
2.25.1

