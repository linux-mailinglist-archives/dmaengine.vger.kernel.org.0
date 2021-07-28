Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041B73D902E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 16:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbhG1OPH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 10:15:07 -0400
Received: from mail.teo-en-ming-corp.com ([194.233.66.226]:45706 "EHLO
        mail.teo-en-ming-corp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbhG1OPG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Jul 2021 10:15:06 -0400
Received: from mail.teo-en-ming-corp.com (mail.teo-en-ming-corp.com [127.0.0.1])
        by mail.teo-en-ming-corp.com (Postfix) with ESMTP id 4GZb8t1bWqzkWq1
        for <dmaengine@vger.kernel.org>; Wed, 28 Jul 2021 22:07:58 +0800 (+08)
Authentication-Results: mail.teo-en-ming-corp.com (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=teo-en-ming-corp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        teo-en-ming-corp.com; h=content-transfer-encoding:content-type
        :organization:message-id:user-agent:reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1627481276; x=1630073277; bh=5TfC1
        R+HWcz/4phYypQXN+kbYSdbs3GuB1ZJ3ojB+K0=; b=zKSoABzA0TwoPXU5Ru/k2
        2lA/LKntCrvkjk43ooGJLjClWokgVjXnhJq3r/S1WHHv3nlze6awsS02c1VmxIXl
        mCAAn8KPkyi8TzFdrk8wX6I16LAU2DtxbBY3N6wyj1UInvqMz+DTs1fOom8R/oZd
        xcC6RCH2XtmWr1iuMYzK0FaDpdetUvwp97tXu0NhBAcYVk2jfUrVtY/5bp49zDvh
        n6ey7MEak1Ez3Nv83Esn0OdAAvdwkua/8V5N1HF3DgTh50fk9tHC4LRuVO5Pfabi
        b7YzQIC3kUJJ6kNvL1u8HKrYcP6+ZyOs5t7kPpg7+Ohgup40YJnDsnXFwEXLXoNI
        Q==
X-Virus-Scanned: Debian amavisd-new at vmi576090.contaboserver.net
Received: from mail.teo-en-ming-corp.com ([127.0.0.1])
        by mail.teo-en-ming-corp.com (mail.teo-en-ming-corp.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id we-AbersAgAQ for <dmaengine@vger.kernel.org>;
        Wed, 28 Jul 2021 22:07:56 +0800 (+08)
Received: from localhost (mail.teo-en-ming-corp.com [127.0.0.1])
        by mail.teo-en-ming-corp.com (Postfix) with ESMTPSA id 4GZb8r0bXCzkWq3
        for <dmaengine@vger.kernel.org>; Wed, 28 Jul 2021 22:07:56 +0800 (+08)
MIME-Version: 1.0
Date:   Wed, 28 Jul 2021 22:07:55 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     dmaengine@vger.kernel.org
Subject: I discovered that UniFi USW-24P-250 POE network switch is based on
 Linux kernel 3.6.5
Reply-To: ceo@teo-en-ming-corp.com
User-Agent: Roundcube Webmail
Message-ID: <0a9534bca5051fc844f1c42d683af085@teo-en-ming-corp.com>
X-Sender: ceo@teo-en-ming-corp.com
Organization: Teo En Ming Corporation
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Subject: I discovered that UniFi USW-24P-250 POE network switch is based=20
on Linux kernel 3.6.5

Good day from Singapore,

I discovered that UniFi USW-24P-250 POE network switch is based on Linux=20
kernel 3.6.5 and other open source software. I had an opportunity to=20
play with this UniFi USW-24P-250 POE network switch recently. The=20
console output and other information below shows that UniFi USW-24P-250=20
POE network switch is based on Linux kernel 3.6.5.

Please DO NOT try to configure UniFi network switches using the CLI. It=20
WILL NOT work. If you configure UniFi network switches using the CLI,=20
the IP address that you have manually configured will always go back to=20
192.168.1.20, which is the default IP address.

The only way to configure UniFi network switches is to connect them to a=20
network environment with DHCP server. You can then install and use UniFi=20
Controller to adopt the UniFi network switch. Configuring UniFi network=20
switches using UniFi Controller (GUI) is extremely easy and straight=20
forward. There is no need to use the CLI at all.

How to Configure UniFi USW-24P-250 POE Network Switch using CLI
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Putty Settings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Connection > Serial:

Speed(baud): 115200
Data bits: 8
Stop bits: 1
Parity: None
Flow control: None

Session:

Serial
Serial line: COM1
Speed: 115200

Default username and password to login to UniFi switch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Default login: ubnt
Default password: ubnt

How to enter CLI of UniFi switch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

telnet localhost

enable

show run

=3D=3D=3DBegin of Default switch configuration=3D=3D=3D

!Current Configuration:
!
!System Description "USW-24P-250, 5.11.0.11599, Linux 3.6.5"
!System Software Version "5.11.0.11599"
!System Up Time          "0 days 0 hrs 24 mins 4 secs"
!Additional Packages     QOS,IPv6 Management
!
network parms 0.0.0.0 0.0.0.0 0.0.0.0
vlan database
exit

configure
line console
exit

line telnet
exit

spanning-tree mode rstp
!
no snmp-server community "public"
no snmp-server community "private"
set igmp reportforward lldp
set mld reportforward lldp
ip dhcp snooping
ip dhcp snooping vlan 1
cos-queue min-bandwidth 0 10 10 10 10 0 0 0
keepalive

interface 0/1
description 'Port 1'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/2
description 'Port 2'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/3
description 'Port 3'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/4
description 'Port 4'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/5
description 'Port 5'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/6
description 'Port 6'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/7
description 'Port 7'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/8
description 'Port 8'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/9
description 'Port 9'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/10
description 'Port 10'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/11
description 'Port 11'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/12
description 'Port 12'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/13
description 'Port 13'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/14
description 'Port 14'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/15
description 'Port 15'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/16
description 'Port 16'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/17
description 'Port 17'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/18
description 'Port 18'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/19
description 'Port 19'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/20
description 'Port 20'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/21
description 'Port 21'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/22
description 'Port 22'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/23
description 'Port 23'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/24
description 'Port 24'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/25
description 'Port 25'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface 0/26
description 'Port 26'
vlan ingressfilter
port-security max-dynamic 0
lldp transmit
lldp receive
lldp transmit-tlv port-desc
lldp transmit-tlv sys-name
lldp transmit-tlv sys-desc
lldp transmit-tlv sys-cap
lldp med
exit



interface lag 1
shutdown
no port-channel static
vlan participation exclude 1
exit



interface lag 2
shutdown
no port-channel static
vlan participation exclude 1
exit



interface lag 3
shutdown
no port-channel static
vlan participation exclude 1
exit



interface lag 4
shutdown
no port-channel static
vlan participation exclude 1
exit



interface lag 5
shutdown
no port-channel static
vlan participation exclude 1
exit



interface lag 6
shutdown
no port-channel static
vlan participation exclude 1
exit


no errdisable recovery cause mac-locking
no errdisable recovery cause denial-of-service
exit

=3D=3D=3DEnd of default switch configuration=3D=3D=3D

show network

Interface Status............................... Up
IP Address..................................... 0.0.0.0
Subnet Mask.................................... 0.0.0.0
Default Gateway................................ 0.0.0.0
IPv6 Administrative Mode....................... Enabled
IPv6 Prefix is ................................=20
fe80::f692:bfff:fe71:aac7/64
Burned In MAC Address.......................... F4:92:BF:71:AA:C7
Locally Administered MAC address............... 00:00:00:00:00:00
MAC Address Type............................... Burned In
Configured IPv4 Protocol....................... None
Configured IPv6 Protocol....................... None
IPv6 AutoConfig Mode........................... Enabled
Management VLAN ID............................. 1

Reference Guide: Getting into the CLI for a Unifi switch
Link:=20
https://dan.langille.org/2018/01/12/getting-into-the-cli-for-a-unifi-swit=
ch/

Reference Guide: Ubiquiti Networks EdgeSwitch CLI Command Reference
Link:=20
https://www.doubleradius.com/site/stores/ubiquiti/Ubiquiti-Edgeswitch-CLI=
-Command-Reference-Quick-Start-Guide.pdf

Configure the management interface of UniFi switch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

hostname UniFi-USW-24P-250-Switch

network parms 192.168.0.6 255.255.255.0 192.168.0.2

(UniFi-USW-24P-250-Switch) #show network

Interface Status............................... Up
IP Address..................................... 192.168.0.6
Subnet Mask.................................... 255.255.255.0
Default Gateway................................ 192.168.0.2
IPv6 Administrative Mode....................... Enabled
IPv6 Prefix is ................................=20
fe80::f692:bfff:fe71:aac7/64
Burned In MAC Address.......................... F4:92:BF:71:AA:C7
Locally Administered MAC address............... 00:00:00:00:00:00
MAC Address Type............................... Burned In
Configured IPv4 Protocol....................... None
Configured IPv6 Protocol....................... None
IPv6 AutoConfig Mode........................... Enabled
Management VLAN ID............................. 1

configure

username admin level 15 password

Enter new password:****************

Confirm new password:****************

write memory


This operation may take a few minutes.
Management interfaces will not be available during this time.

Are you sure you want to save? (y/n) y

Config file 'startup-config' created successfully .


Configuration Saved!

UBNT-US.v5.11.0# reboot now
UBNT-US.v5.11.0# + exec
umount: can't remount rootfs read-only
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to[  991.180000] Disabling non-boot CPUs ...
[  991.180000] Restarting system.


U-Boot usw-v1.1.4.115-g14af1ee6 (Feb 14 2017 - 18:50:54)

DEV ID=3D 0000db56
SKU ID =3D 0x8344
DDR type: DDR3
MEMC 0 DDR speed =3D 667MHz
Validate Shmoo parameters stored in flash ..... OK
Press Ctrl-C to run Shmoo ..... skipped
Restoring Shmoo parameters from flash ..... done
Running simple memory test ..... OK
DDR Tune Completed
DRAM:  256 MiB
WARNING: Caches not enabled

  soc_pcie_hw_init : port->reg_base =3D 0x18012000 , its value =3D 0x1
PCIe port 0 in RC mode

  pos is 172
=3D=3D>PCIE: LINKSTA reg 0xbe val 0x1001

**************
  port 0 is not active!!
**************
In:    serial
Out:   serial
Err:   serial
Unlocking L2 Cache ...Done
arm_clk=3D400MHz, axi_clk=3D200MHz, apb_clk=3D50MHz, arm_periph_clk=3D200=
MHz
Disabling outer cache
Net:   Board Net Initialization Failed
No ethernet found.
Hit any key to stop autoboot:  0
ubnt_bootsel_init: bootsel magic=3Da34de82b, bootsel =3D 0
UBNT application initialized
Boot partition selected =3D 0
Loading Kernel Image @ 1000000, size =3D 15728640
Verifying 'kernel0' parition:OK
## Booting kernel from Legacy Image at 01000000 ...
    Image Name:   Ubiquiti 5.11.0.11599
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    15068480 Bytes =3D 14.4 MiB
    Load Address: 00018000
    Entry Point:  00018000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK
boot_prep_linux commandline: console=3DttyS0,115200 mem=3D128M@0x0=20
mem=3D128M@0x68000000=20
mtdparts=3Dspi1.0:768k(u-boot),64k(u-boot-env),64k(shmoo),15360k(kernel0)=
,15424k(kernel1),1024k(cfg),64k(EEPROM)=20
ubntbootid=3D0

Starting kernel ...

Disabling outer cache
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.6.5 (builder@link-owrt1505-builder) (gcc=20
version 4.7.2 (OpenWrt GCC 4.7.2 unknown) ) #2 SMP Wed Apr 22 10:09:32=20
MDT 2020
[    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7),=20
cr=3D10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing=20
instruction cache
[    0.000000] Machine: Broadcom iProc
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] BUG: mapping for 0x18000000 at 0xf0000000 out of vmalloc=20
space
[    0.000000] BUG: mapping for 0x19000000 at 0xf1000000 out of vmalloc=20
space
[    0.000000] PERCPU: Embedded 7 pages/cpu @c1caf000 s6272 r8192 d14208=20
u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. =20
Total pages: 61952
[    0.000000] Kernel command line: console=3DttyS0,115200 mem=3D128M@0x0=
=20
mem=3D128M@0x68000000=20
mtdparts=3Dspi1.0:768k(u-boot),64k(u-boot-env),64k(shmoo),15360k(kernel0)=
,15424k(kernel1),1024k(cfg),64k(EEPROM)=20
ubntbootid=3D0 ubootver=3Dusw-v1.1.4.115-g14af1ee6
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536=20
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768=20
bytes)
[    0.000000] Memory: 128MB 128MB =3D 256MB total
[    0.000000] Memory: 244992k/244992k available, 17152k reserved,=20
131072K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf0000000   ( 632 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0018000 - 0xc034d7f8   (3286 kB)
[    0.000000]       .init : 0xc034e000 - 0xc0e4c880   (11259 kB)
[    0.000000]       .data : 0xc0e4e000 - 0xc0e76d40   ( 164 kB)
[    0.000000]        .bss : 0xc0e76d64 - 0xc0ea5354   ( 186 kB)
[    0.000000] SLUB: Genslabs=3D11, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0,=20
CPUs=3D1, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D1.
[    0.000000] NR_IRQS:292
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns,=20
wraps every 4294967286ms
[    0.010000] Calibrating delay loop... 795.44 BogoMIPS (lpj=3D3977216)
[    0.050000] pid_max: default: 4096 minimum: 301
[    0.050000] Mount-cache hash table entries: 512
[    0.050000] CPU: Testing write buffer coherency: ok
[    0.050000] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.050000] Setting up static identity map for 0x282350 - 0x2823a8
[    0.050000] L310 cache controller enabled
[    0.050000] l2x0: 8 ways, CACHE_ID 0x410000c9, AUX_CTRL 0x0a120000,=20
Cache size: 131072 B
[    0.050000] Brought up 1 CPUs
[    0.050000] SMP: Total of 1 processors activated (795.44 BogoMIPS).
[    0.050000] devtmpfs: initialized
[    0.060000] NET: Registered protocol family 16
[    0.060000] DMA: preallocated 256 KiB pool for atomic coherent=20
allocations
[    0.060000] GENPLL[5] mdiv=3D40 rate=3D2000000000
[    0.060000] Sel=3D1 Ovr=3D1 Div=3D48
[    0.060000] UART clock rate 50000000
[    0.080000] bio: create slab <bio-0> at 0
[    0.080000] Bluetooth: Core ver 2.16
[    0.080000] NET: Registered protocol family 31
[    0.080000] Bluetooth: HCI device and connection manager initialized
[    0.080000] Bluetooth: HCI socket layer initialized
[    0.080000] Bluetooth: L2CAP socket layer initialized
[    0.080000] Bluetooth: SCO socket layer initialized
[    0.080000] Switching to clocksource iproc_gtimer
[    0.090000] NET: Registered protocol family 2
[    0.090000] TCP established hash table entries: 4096 (order: 3, 32768=20
bytes)
[    0.090000] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.090000] TCP: Hash tables configured (established 4096 bind 4096)
[    0.090000] TCP: reno registered
[    0.090000] UDP hash table entries: 128 (order: 0, 4096 bytes)
[    0.090000] UDP-Lite hash table entries: 128 (order: 0, 4096 bytes)
[    0.090000] NET: Registered protocol family 1
[   14.360000] pm_init: Initializing Power Management ....
[   14.360000] iproc gpiochip add GPIOA
[   14.360000] GPIOA:ioaddr f0000060
[   14.360000] GPIOA:intr_ioaddr f0000000 dmu_ioaddr   (null)
[   14.610000] PCIE0: LINKSTA reg 0xbe val 0x1001
[   14.610000] reg[0xac]=3D0x10, reg[0xae]=3D0x42, reg[0xb0]=3D0x8000,=20
reg[0xb4]=3D0x2c10, reg[0xb6]=3D0x10, reg[0xb8]=3D0x5c12, reg[0xba]=3D0x6=
5,=20
reg[0xbe]=3D0x1001, reg[0xc6]=3D0x40, reg[0xca]=3D0x1, reg[0xd0]=3D0x1f,=20
reg[0xd2]=3D0x8, reg[0xdc]=3D0x1, PCIE0 link=3D0
[   14.860000] PCIe port 1 in End-Point mode - ignored
[   14.860000] Registering iproc_pmu_device
[   14.860000] bounce pool size: 64 pages
[   14.880000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   14.880000] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[   14.880000] msgmni has been set to 222
[   14.880000] Block layer SCSI generic (bsg) driver version 0.4 loaded=20
(major 254)
[   14.880000] io scheduler noop registered
[   14.880000] io scheduler deadline registered (default)
[   14.880000] io scheduler cfq registered
[   14.880000] Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
[   14.890000] serial8250.0: ttyS0 at MMIO 0x18000400 (irq =3D 123) is a=20
16550A
[   15.360000] console [ttyS0] enabled
[   15.370000] serial8250.0: ttyS1 at MMIO 0x18000300 (irq =3D 123) is a=20
16550A
[   15.400000] brd: module loaded
[   15.410000] loop: module loaded
[   15.420000] nbd: registered device at major 43
[   15.440000] tun: Universal TUN/TAP device driver, 1.6
[   15.450000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   15.450000] Bluetooth: HCI UART driver ver 2.2
[   15.460000] Bluetooth: HCI H4 protocol initialized
[   15.460000] Bluetooth: HCI BCSP protocol initialized
[   15.470000] TCP: cubic registered
[   15.470000] NET: Registered protocol family 10
[   15.480000] sit: IPv6 over IPv4 tunneling driver
[   15.490000] NET: Registered protocol family 17
[   15.490000] Bluetooth: RFCOMM TTY layer initialized
[   15.500000] Bluetooth: RFCOMM socket layer initialized
[   15.500000] Bluetooth: RFCOMM ver 1.11
[   15.510000] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   15.510000] Bluetooth: BNEP filters: protocol multicast
[   15.520000] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   15.520000] 8021q: 802.1Q VLAN Support v1.8
[   15.530000] GENPLL[5] mdiv=3D40 rate=3D2000000000
[   15.530000] qspi_iproc qspi_iproc.1: 1-lane output, 3-byte address
[   15.540000] m25p80 spi1.0: found mx25l25635e, expected m25p80
[   15.550000] m25p80 spi1.0: mx25l25635e (32768 Kbytes)
[   15.550000] 7 cmdlinepart partitions found on MTD device spi1.0
[   15.560000] Creating 7 MTD partitions on "spi1.0":
[   15.560000] 0x000000000000-0x0000000c0000 : "u-boot"
[   15.570000] 0x0000000c0000-0x0000000d0000 : "u-boot-env"
[   15.580000] 0x0000000d0000-0x0000000e0000 : "shmoo"
[   15.580000] 0x0000000e0000-0x000000fe0000 : "kernel0"
[   15.590000] 0x000000fe0000-0x000001ef0000 : "kernel1"
[   15.600000] 0x000001ef0000-0x000001ff0000 : "cfg"
[   15.610000] 0x000001ff0000-0x000002000000 : "EEPROM"
[   15.640000] Freeing init memory: 11256K
[   15.700000] ubnt_common: module license 'Proprietary' taints kernel.
[   15.710000] Disabling lock debugging due to kernel taint
[   15.780000] Data abort at addr=3D0xc8a10224, fsr=3D0x1406 ignored.
[   15.790000] Data abort at addr=3D0xc8a10224, fsr=3D0x1406 ignored.
[   15.810000] gpiodev: reset_timeout=3D3
Could not find cfg type: 1
Could not find cfg type: 2
...running /sbin/init
init started: BusyBox v1.23.2 (2020-04-22 10:04:15 MDT)
+ exec
Restoring EEPROM data from ubnthal
MAC: f4:92:bf:71:aa:c7
Validating the active image /dev/mtd3..."5.11.0.11599"
Validating the backup image /dev/mtd4..."5.11.0.11599"
DMA pool size: 4194304
AXI unit 0: Dev 0x8344, Rev 0x01, Chip BCM53344_A0, Driver BCM56150_A0
SOC unit 0 attached to PCI device BCM53344_A0


(Unit 1)>

Applying Global configuration, please wait ...

Applying Interface configuration, please wait ...

Please press Enter to activate this console. inform sent
inform sent
inform sent

Using the UniFi Controller to adopt the UniFi Switch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

192.168.0.10 is the UniFi Controller on the management laptop.

UBNT-US.v5.11.0# set-inform http://192.168.0.10:8080/inform

Adoption request sent to 'http://192.168.0.10:8080/inform'.  Use the=20
controller to complete the adopt process.

telnet localhost

enable

network parms 192.168.0.6 255.255.255.0 192.168.0.2

UBNT-US.v5.11.0# info

Model:       USW-24P-250
Version:     5.11.0.11599
MAC Address: f4:92:bf:71:aa:c7
IP Address:  192.168.1.20
Hostname:    UBNT
Uptime:      7868 seconds

Status:      Connected (http://192.168.0.10:8080/inform)

Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 28 July 2021, is=20
a TARGETED INDIVIDUAL living in Singapore. He is an IT Consultant with a=20
System Integrator (SI)/computer firm in Singapore. He is an IT=20
enthusiast.





--=20
-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.ht=
ml

*************************************************************************=
*******************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
