Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88D7D57CF
	for <lists+dmaengine@lfdr.de>; Tue, 24 Oct 2023 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjJXQTK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Oct 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjJXQTJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Oct 2023 12:19:09 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3375583;
        Tue, 24 Oct 2023 09:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3mZ9up0DS0iq3T/TPW9gP4j/Vfzh+AW7/KKWcgCKF078d999jqHZzA4shGoYRJ2H0CHmH5O36bmzS66regxhTHhAyLr+eXruggkGBVvP1XoFeta6yX1x+ktobVSH5ZhGhs/0x007F1XSrIqh/XEnSIecr2si4dXRDHneStoxdc72ltlZ+BHivDPZMpZRp7w2qQ/rX4ZqeTKpTilVl+uH7aRvD5U3e30VImvemn2rIWpisFhwNklRgrZ7zRa3tTGlUYzwWeOupz53USr/ZSlcL7Ar1HE0BWuT/CYkcLxkczAHkkMdmc5JjatH5RR+eXEBSMX3I5S606sSLjMjjrhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcPvm5fQYsFvYgxjANJVuxNz8VoNzC9fBhLgQtpIk4Q=;
 b=Nu1T7WxkhsgWwk7n+EnG5FuKnsruULhSbG4jEpDAWIv6RP4OiZODfMtpu9Urms+NlB4JKl4nxScu2AdI7gpQW4oq49h3Ak5hizLnxyYBLc2PAzfrlONU7OFJ2sU/TvKXrQVqplQylvDPkfEDBO+ImejLCNCOsOVI3UC9AauhfGxFCBFp0EoV5Z6Clna/yXFddeZH0jIF9mtgJYrRx+uQ24Vigoe2KC2l/4COF9uubtkFMA1u3xNp0qZaTNeOJrFy2SnfAlSh8meYXZpKCq3cSePkcaCPeYWLG8J925bHoNiyu8sT1G+dHBVlkWVp5m8DMCmN+lyNQU6JeqfHnN+Uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcPvm5fQYsFvYgxjANJVuxNz8VoNzC9fBhLgQtpIk4Q=;
 b=ZLhToIDK09shd67dIQ1z1e7Rwx2rad/Vv6A891lqFHpsz8c8WuJygFwTaiSJrprq/38tCpLMkYABykBA9KZvy9ko8xeg+Yoef+FbyV89x56hoicpcvOKBBcAhAyt7SQ+vohgQzTrcHHE13GHCRPtrrtgi70rpu6yroYCf6tT+sg=
Received: from BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 16:19:01 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::8e) by BLAPR03CA0090.outlook.office365.com
 (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 16:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 16:19:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 11:19:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 09:19:00 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 24 Oct 2023 11:18:59 -0500
Message-ID: <415ae047-0c9e-1e85-f4ff-e17a63aa0dfc@amd.com>
Date:   Tue, 24 Oct 2023 09:18:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] media: pci: mgb4: remove bogus 'select' statements
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        "Martin Tuma" <martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <dmaengine@vger.kernel.org>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231023160539.1537355-1-arnd@kernel.org>
 <20231023160539.1537355-2-arnd@kernel.org>
 <78427021-ddc0-45b6-a16b-bf8bc8f84003@app.fastmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <78427021-ddc0-45b6-a16b-bf8bc8f84003@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 9952336f-fa43-4b4c-ede7-08dbd4acef14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0w3HZq9YaCqnRRX/Zy2nYSX3C1pUEPx7Y8C6dmOOXeD8IndxlBT4zWJk2Hefz9ljKlOE+8Q93kz8qnC3hvuB6OMSSbOLSOQLC2zyUh0cPjD1tj8MwlgjXZvhsve0KcfCFlawMX8O7gN/c8BkXjruVta4Bt2mjctyy3+4QGpE/2HnQh1BpnWwY0sU5wNe3P/2bhyVGROIOFCN/o1u6OIhTT2QFwnoPTYZnxt18B6bqRyQPfSxoTCroN2bYcCZ4rIXIoGCsUEIN6q2nx14En94jrvoQxx9QmDuxOwGb6Y+7X7LoRLUEVGSJQI/kr1ktNZKIpBFT29otAKUG9OAXkoGYT8q2XXcdeHOMyQGDcsmCGusHvJjGSnCQkfMmPu9BK5yiNBBsvAVmC3+f+B1d0czlFXfd3N/8GFcy9FRvJdpQNU9EHMyivLSeMUUGRDyDQAqRB9EKpcLxS9C99M14OBxhv1V1KVZ7t8DYAhAEgBnWlvoga/zL3Fk5zbJpRsEmZKCE7Q8zJzsMHFdlZ7vFi3IgUHZfAZCH3ZaMR8WXsqu1Z4uhhvKCX14SFtlLB6HRYng7Nkve4orp8VXWE/6AcpdPKp1MepzJdIdkfB8oWYQf2hH+3tnL3g9XWo3CRZI22ZocvJuFBEYTLCJUDIXDGAEQhunBljmEOqQx7GYhE+0/3FIbLPMA2pM0flRE32iIwDBwktp/TmPDzUbXCN0tkt0HsxvJcewxauH/8ih6KH4WVqi/od5IeyQ5rqoVAZKq6REZDCpcscbiV6HgIX8jqRtTVQuDbcd2w5K6ncbfMZwb9ITE1sPUwScX1bsL47WxNyda8w9ZT1RZSYzUsuok/wNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(40480700001)(110136005)(16576012)(86362001)(70206006)(70586007)(41300700001)(316002)(31696002)(966005)(5660300002)(478600001)(54906003)(8676002)(4326008)(36756003)(8936002)(53546011)(2906002)(36860700001)(81166007)(356005)(2616005)(26005)(336012)(426003)(82740400003)(44832011)(47076005)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:19:01.3178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9952336f-fa43-4b4c-ede7-08dbd4acef14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/24/23 06:27, Arnd Bergmann wrote:
> On Mon, Oct 23, 2023, at 18:05, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> As this is just a regular device driver, it has no business force-enabling
>> other drivers in the system, it should be entirely independent of the
>> implementation of the spi-nor layer or the specific DMA engine.
>>
>> The IIO symbols that are selected here are library modules that
>> are legitimately used.
>>
>> Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/media/pci/mgb4/Kconfig | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/media/pci/mgb4/Kconfig b/drivers/media/pci/mgb4/Kconfig
>> index f2a05a1c8ffa..b90347c7f19b 100644
>> --- a/drivers/media/pci/mgb4/Kconfig
>> +++ b/drivers/media/pci/mgb4/Kconfig
>> @@ -6,10 +6,6 @@ config VIDEO_MGB4
>>   	select VIDEOBUF2_DMA_SG
>>   	select IIO_BUFFER
>>   	select IIO_TRIGGERED_BUFFER
>> -	select I2C_XILINX
>> -	select SPI_XILINX
>> -	select MTD_SPI_NOR
>> -	select XILINX_XDMA
> Apparently, the XDMA reference was in fact needed, as MGB4
> calls some exported symbols from that particular dmaengine
> driver:
>
> aarch64-linux-ld: drivers/media/pci/mgb4/mgb4_core.o: in function `init_i2c': mgb4_core.c:(.text+0x3ec): undefined reference to `xdma_get_user_irq'
> aarch64-linux-ld: mgb4_core.c:(.text+0x404): undefined reference to `xdma_enable_user_irq'
>
> I couldn't easily figure out what a 'user_irq' is here,
> but I wonder if this is the expected way to use the DMA engine
> layer. Maybe this should have been a nested irqchip instead,
> or it should be encoded in the DMA request specifier?

Hi Arnd,

Here is a brief description of 'user_irq' and 'xdma_enable_user_irq'

The XDMA subsystem is used in conjunction with the PCIe IP block. Please 
see https://lwn.net/Articles/911496/ for the overall information.

XDMA can forward PCIe msi-x interrupt to/from user logic hardware (e.g. 
Digiteq device) which is connected to its user irq pin.  And XDMA has a 
register to enable/disabe interrupt forwarding for a specific user irq pin.

'xdma_enable_user_irq' and 'xdma_disable_user_irq' are provided for 
hardware driver which is designed to use XDMA to enable/disable its 
interrupt. And based on the previous discussion with Mark, Digiteq 
device does not use its own register to enable/disable interrupt but 
relies on XDMA.  Please see 
https://lore.kernel.org/lkml/daccee4a-ac3c-bfc1-4876-24e6ecf5bcf1@gpxsee.org/

Thanks,

Lizhi

>
>       Arnd
